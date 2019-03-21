class Guidance < ApplicationRecord
  
  belongs_to :parent, class_name: "Guidance", optional: true
    
  acts_as_tree order: "id"  
  belongs_to :security_control, optional: true
  belongs_to :requirement , optional: true
  
  before_destroy :clean_up
  
  def clean_up
      RelatedRef.clean_references_before_destory(self)
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
      json.class "guidance"
      if (show_monarc_id)
        json.monarc_id self.id
      end
      json.prose [self.description.strip]
      related_controls = RelatedRef.grab_refs_by_type(self, "related", "owner") 
      if has_data?(related_controls) 
        json.links(related_controls) do |related_control| 
          json.rel related_control.rel
          link = "#" + "#{related_control.title.downcase}"
          json.href link
        end
       end
    end
  end
end
