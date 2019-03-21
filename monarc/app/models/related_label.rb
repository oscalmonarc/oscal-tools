class RelatedLabel < ApplicationRecord
  belongs_to :label
  belongs_to :provider , optional: true
  
  validates_presence_of :object_type, :object_id
  
  
  #Returns the related object
  def self.grab_related_object
     the_object_type = Object.const_get(self.object_type)
     the_object = the_object_type.find(self.object_id)
    return the_object
  end

  
  def self.grab_related_labels(object)
    
    the_objects = RelatedLabel.includes(:label).where(object_id: object.id, object_type: object.class.name)
    labels = []
      
    if (the_objects != nil) && (the_objects.count > 0)
      the_objects.each do |related_label|
        labels << related_label.label
      end
      return labels
    end
    return nil
  end
  
  #Returns the url for the related object
  def self.grab_related_object_url
    related = grab_related_object
    the_url = ""
    if (self.object_type == "ref") || (self.object_type == "Ref")
      the_ref = Ref.find(self.object_id)
      the_url = "<a href ='#{the_ref.url}' target='_blank'>#{the_ref.title}</a>"
    else
      object = related
      the_url = object.the_url  
    end
    return the_url.html_safe()
   end
   
   # will find and set the label to an object
   def self.set_related_label(label_name, parent_label_name, related_object)
     label = nil
     if (parent_label_name != nil)
        parent_label = Label.find_or_create_by(name: parent_label_name)
        label = Label.find_or_create_by(name: label_name, parent:  parent_label)
        
     else
       label = Label.find_or_create_by(name: label_name)
     end
     if (label != nil)
        object_type = related_object.class.name.capitalize
        object_id = related_object.id
        related_label = RelatedLabel.find_or_create_by(label: label, object_type: object_type, object_id: object_id)
     end
   end

end
