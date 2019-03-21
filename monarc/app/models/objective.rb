class Objective < ApplicationRecord
  acts_as_tree order: "name"
    
  belongs_to :parent, class_name: "Objective", optional: true
  belongs_to :security_control, optional: true
  belongs_to :requirement, optional: true
  belongs_to :parent_objective, class_name: "Objective", optional: true
  has_many :control_implementations,  dependent: :destroy
  
  before_destroy :clean_up
  
  def clean_up
    RelatedRef.clean_references_before_destory(self)
  end  
   
  #returns the url as a clickable link for this object
  def click_link 
    url = "<a href='/objectives/#{self.id}'>#{self.objective_id}</a>"
        return url.html_safe
  end
    
  #returns the url for this object  
  def the_url
      return Rails.application.routes.url_helpers.objective.url(self, only_path: true)
  end
  
  #checks if name is set and returns it, if not returns View
  def grab_name
    if (self.name == "")
      return "View"
    else
      return self.name 
    end
  end
  
  #grabs the children of this objective
  def grab_children
    children = Objective.where(parent_id: self.id)
    return children 
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
  #If show_monarc_id is true, it will add an monarc_id to the output, which is not standard in OSCAL.  def convert_to_oscal_json(children, show_monarc_id)
  def convert_to_oscal_json(children, show_monarc_id)
     objectives_array = []
      
     Jbuilder.new do |json|
      if (self.parent_id != nil)
        json.id self.objective_id
      end
      json.class "objective"
      if (show_monarc_id)
        json.monarc_id self.id
      end
      if (self.description != nil)
        json.prose [self.description.strip.to_s]
      end
      
      if (children)
        tmp_children = self.children
        if (tmp_children  != nil) && (tmp_children .size > 0)
         children_array = []
         tmp_children .each do |objective|
            children_array << objective.convert_to_oscal_json(children, show_monarc_id).attributes!
         end
         json.parts children_array
        end
      end
    end
  end
end
