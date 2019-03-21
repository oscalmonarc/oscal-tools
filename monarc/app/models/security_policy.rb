class SecurityPolicy < ApplicationRecord
  acts_as_tree order: "name"
  
  belongs_to :parent, class_name: "SecurityPolicy", optional: true
  belongs_to :provider
  
  has_many :requirements, dependent: :destroy
  has_many :security_control_families , dependent: :destroy
  has_many :security_controls, dependent: :destroy
  
  has_many :params, :through => :security_controls
  has_many :param_values, :through => :params
  has_many :statements, :through => :security_controls
  has_many :items, :through => :statements
  has_many :assessments, :through => :security_controls
  has_many :assessment_objects, :through => :assessments
  has_many :objectives, :through => :security_controls
  has_many :guidances, :through => :security_controls
  has_many :related_controls, :through => :security_controls
  has_many :related_refs, :through => :security_controls
  validates_presence_of :name, :version
  
  #policy = SecurityPolicy.find(3)
  #
  #controls = policy.security_controls
    
  def the_url
    return "/policy/#{self.name}/version/#{self.version}"
  end
  
  def click_link
      link = "<a href='#{self.the_url}'>#{self.policy_version}</a>"
      return  link.html_safe
    end
    
  def policy_version
    return "#{name}  rev #{version}"
  end
  
  def other_versions
    historic_policies = SecurityPolicy.where(name: self.name).where.not(version: self.version)
    return historic_policies 
  end
  
  def show_oscal_detailed_list
    Jbuilder.new do |json|
    json.catalog do 
      json.title "#{provider} #{name}"
      json.monarc_id self.id
      json.declarations do
        decleration = "#{provider}_SP-800-53_#{version}_declarations.xml" 
        json.href decleration
      end
    end 
   end
  end
  
  #Calls the convert_to_oscal_json method, saying children is false, and monarc ID is true.
  def show_oscal_with_eid
     return convert_to_oscal_json(false, true)
   end
   
   #Calls the convert_to_oscal_json method, saying children is true, and monarc ID is true.
   def show_oscal_detailed_with_eid
     return convert_to_oscal_json(true, true)
   end

   #Calls the convert_to_oscal_json method, saying children is true, and monarc ID is false.
   def show_oscal_detailed
     return convert_to_oscal_json(true, false)
   end
  
  #Will return,an JSON object. 
  #If Children is set to true, it will also include the children objects.
  #If show_monarc_id is true, it will add an monarc_id to the output, which is not standard in OSCAL. 
  def convert_to_oscal_json(children, show_monarc_id)
  
    Jbuilder.new do |json|
      json.catalog do 
        json.title "#{provider} #{name}"
        if (show_monarc_id)
          json.monarc_id self.id
        end
        json.declarations do
          decleration = "#{provider}_SP-800-53_#{version}_declarations.xml" 
          json.href decleration
        end
        if children
          refs_array = []
          the_refs = Ref.all
          the_refs.each do |ref|
            refs_array << ref.convert_to_oscal_json(children, show_monarc_id).attributes!
          end
          json.references do
            json.refs refs_array 
          end
          
          family_array = []
          security_control_families.each do |security_control_family|
              family_array  << security_control_family.convert_to_oscal_json(children, show_monarc_id).attributes!  
          end
          json.groups [family_array]
        end        
      end 
     end
  end
end
