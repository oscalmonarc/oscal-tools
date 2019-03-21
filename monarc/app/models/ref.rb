class Ref < ApplicationRecord
  has_many :related_refs
  
  #Calls the convert_to_oscal_json method, saying children is false, and monarch ID is true.
  def show_oscal_with_eid
     return convert_to_oscal_json(false, true)
   end

   #Calls the convert_to_oscal_json method, saying children is true, and monarch ID is true.
   def show_oscal_detailed_with_eid
     return convert_to_oscal_json(true, true)
   end
   #Calls the convert_to_oscal_json method, saying children is true, and monarch ID is false.
   def show_oscal_detailed
     return convert_to_oscal_json(true, false)
   end

  #Will return,an JSON object. 
  #If Children is set to true, it will also include the children objects.
  #If show_monarch_id is true, it will add an monarch_id to the output, which is not standard in OSCAL.  def convert_to_oscal_json(children, show_monarch_id)
  def convert_to_oscal_json(children, show_monarch_id)
      Jbuilder.new do |json|
        
        json.id self.ref_id
        if (show_monarch_id)
          json.monarch_id self.id
        end
        json.citations do
          json.href self.url
          json.value self.title
        end
      end
  end
    
end
