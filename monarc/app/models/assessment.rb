class Assessment < ApplicationRecord
  acts_as_tree order: "method"
  before_destroy :destroy_the_children
  
  belongs_to :parent, class_name: "Assessment", optional: true
  has_many :assessment_objects,  dependent: :destroy
  belongs_to :security_control, optional: true
  belongs_to :requirement , optional: true
  validates_presence_of :method
  
    self.per_page = 25
  
  
  #Generates the url for this object
  def the_url
      return Rails.application.routes.url_helpers.assessment.url(self, only_path: true)
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
    assessment = self
    Jbuilder.new do |json|
      json.class "assessment"
      if (show_monarc_id)
        json.monarc_id self.id
      end
      json.props do
        json.class "method"
        json.monarc_ID assessment.id
        json.value assessment.method.upcase
      end
     
      if(children)
       json.parts do
         json.class "objects"
         the_array = []
         assessment.assessment_objects.each do |the_ao|
           the_array << the_ao.description
         end
         json.prose the_array
       end
     end
   end
  end
end
