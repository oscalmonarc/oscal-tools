class SecurityControlFamily < ApplicationRecord
  has_many  :security_controls, dependent: :destroy
  belongs_to :security_policy
  
  validates_presence_of :title, :abv, :security_policy, :family
  
  
  #returns the abv as the name
  def grab_name
      return self.abv
  end
  
  alias :name :grab_name
  def grab_secrutiy_controls
    policy = self.security_policy
    policy_name = policy.name
    version = policy.version
    
    count = 1
    controls = self.security_controls
    tmp_data = ""
    if (controls != nil) 
      
      controls.each do |security_control| 
        tmp_data = tmp_data +  "<a href='/policy/#{policy_name}/version/#{version}/security_control/#{security_control.control_id}'>#{security_control.name}</a>"
        
      if (count < controls.size)
        tmp_data = tmp_data +  " | "
        if (count % 5 == 0)
          tmp_data = tmp_data +  "<br>"
        end 
        count = count +1
      end
    end 
   end
   return tmp_data.html_safe
  end
  
  #Returns the url connected to the policy of this family.
  def the_url
      name = self.family
      name = name.gsub " ", ""
      return "/policy/#{self.security_policy.name}/version/#{self.security_policy.version}/security_control_family/#{self.family}"
  end
  
  #returns a url to compare 2 security famlies. 
  def grab_compare_url(version)
        return "#{the_url}/compare/#{version}"
  end
  
  # Not sure why i have family hardcoded here...
  def the_class
    
    return "family"
  end
  
  #returns the family as title, and cleans it up.
  def title
    tmpfamily = family
    tmpfamily = tmpfamily.downcase 
    tmpfamily = tmpfamily.split.map(&:capitalize).join(' ')
    tmpfamily = tmpfamily.gsub "And", "and"
    return tmpfamily
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
      json.class "family"
      if (show_monarc_id)
        json.monarc_id self.id
      end
      json.title self.title
      if (children)
        control_array = []
        self.security_controls.each do |security_control|
          control_array  << security_control.convert_to_oscal_json(children, show_monarc_id).attributes!
        end
        json.controls control_array
      end
    end
  end
  
  #returns the security controls tied to this family.
  def grab_controls 
      the_controls = self.security_controls
      control_output = ""
      control_count = the_controls.size
        
      if (control_count >  0) 
        count = 1
        control_output = control_output  + "<p style='padding-left:1em;' align='left'> |"
        
        the_controls.each do |security_control|
          policy = security_control.security_policy
          control_output = control_output  + security_control.the_url
            
           if (count < self.security_controls.size) 
            control_output = control_output  + " | "
            if (count % 6 == 0)
              control_output = control_output  + "<br>"
            end 
            count = count +1 
          end 
        end
      else
        control_output = control_output  + "No Controls found"
      end
      return control_output.html_safe
  end
end
