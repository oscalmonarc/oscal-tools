class Statement < ApplicationRecord
  
  belongs_to :security_control, optional: true
  belongs_to :requirement, optional: true
  belongs_to :parent, class_name: "Statement", optional: true
  has_many :control_implementations,  dependent: :destroy
  has_many :params,  dependent: :destroy
  has_many :items,  dependent: :destroy
  
  
  #has_many :child_statements,  through: :parent_statement
  def click_link
    url = "<a href='/statements/#{self.id}'>#{self.statement_id}</a>"
    return url.html_safe
  end
  #Returns the url for the object
  def the_url
    url = "<a href='/statements/#{self.id}'>#{self.statement_id}</a>"
    return url.html_safe
    #return click_link
  end

  def get_control_id
    id = nil
    if (self.security_control != nil)
      id = self.security_control.control_id
      
    end
    return id
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
      json.class "statement"
      if (show_monarc_id)
        json.monarc_id self.id
      end
      json.prose self.description.strip
      #Set Statement Items
      item_array = []
      if (self.items != nil) && (self.items.size > 0)
        self.items.each do |item|
          item_array <<  item.convert_to_oscal_json(children, show_monarc_id).attributes!
        end
        json.parts item_array
      end
       
    end
     
  end
end


