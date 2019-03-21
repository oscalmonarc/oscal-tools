class Item < ApplicationRecord
  
  acts_as_tree order: "name"  
  belongs_to :parent, class_name: "Item", optional: true
  belongs_to :statement
  has_many :params,  dependent: :destroy
  has_many :control_implementations,  dependent: :destroy
  
  before_destroy :destroy_the_children, :clean_up
  
  def clean_up
    RelatedRef.clean_references_before_destory(self)
  end  
  
  
  
  #returns the children as items
  def items
    self.children
  end
      
  #returns a url of this object.
  def the_url
      return Rails.application.routes.url_helpers.item.url(self, only_path: true)
  end
  
  #returns the security control tied to the parent statement tied to this item. 
  def security_control
    return self.statement.security_control
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
   item = self
   Jbuilder.new do |json|
      if (item.item_id != nil)
        json.id item.item_id
      else
        json.id "PLEASESETME"
      end
      json.class "item"
     if (show_monarc_id)
       json.monarc_id self.id
     end
      json.props do 
        json.class "name"
        name = item.name
        name = name.gsub " ", ""
        name = name.gsub "(", " ("
        json.value name
      end
      json.prose [item.description.strip.to_s]
      tmpchildren = self.children
      if (children)
        if (tmpchildren != nil) && (tmpchildren.size > 0 )
          children_array = []
          tmpchildren.each do |child_item|
            children_array << child_item.convert_to_oscal_json(children, show_monarc_id).attributes!
          end
          json.parts children_array
        end
      end
    end
  end
end
