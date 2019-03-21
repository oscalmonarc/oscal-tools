class RelatedRef < ApplicationRecord
  #validates_presence_of :security_control_id, :object_id, :object_type, :rel
  validates :rel, acceptance: { accept: ['related', 'reference', 'corresp', 'incorporated-into'] } 
    
  #Returns the related object
  def grab_related_object
     the_object_type = Object.const_get(self.object_type)
     the_object = the_object_type.find(self.object_id)
    return the_object
  end

  def grab_owner_object
    the_owner_object_type = Object.const_get(self.owner_object_type)
    
    the_object = the_owner_object_type.find(self.owner_object_id)
    return the_object
  end

  #used to clean up references before destorying
  def self.clean_references_before_destory(tmp_object)
      references = RelatedRef.grab_refs_by_type(tmp_object, "any", "both")
      tmp = RelatedRef.new
      if tmp.has_data?(references)
        references.each do |ref|
          ref.destroy
        end
      end
      labels = RelatedLabel.grab_related_labels(tmp_object)
      if tmp.has_data?(labels)
        labels.each do |label|
          label.destroy
        end
      end
  end
    
  def self.grab_refs_by_type(object, type, relation)
     object_type = object.class.name.capitalize
     object_id = object.id
     references = []
     if (type == "any")
       if (relation == "owner")
         references = RelatedRef.where(owner_object_type: object_type, owner_object_id: object_id)
       elsif (relation == "referenced")|| (relation == "related")
         references = RelatedRef.where(object_type: object_type, object_id: object_id)
       elsif (relation == "both") || (relation == "all")
         references = RelatedRef.where(owner_object_type: object_type, owner_object_id: object_id)
         references = references + RelatedRef.where(object_type: object_type, object_id: object_id)
       end
     else
       
       if (relation == "owner")
         references = RelatedRef.where(owner_object_type: object_type, owner_object_id: object_id, rel: type)
       elsif (relation == "referenced") || (relation == "related")
         references = RelatedRef.where(object_type: object_type, object_id: object_id, rel: type)
       elsif (relation == "both") || (relation == "all")
           references = RelatedRef.where(owner_object_type: object_type, owner_object_id: object_id, rel: type)
           references = references + RelatedRef.where(object_type: object_type, object_id: object_id, rel: type)
         end
         
       end
       if references != nil
         return references
       end
    end
  
  def set_missing_related_control
    owner_ref = grab_owner_object
    new_title = self.title.gsub " ", ""
    new_title = new_title.gsub "(", "."
    new_title = new_title.gsub ")", "" 
    
    the_object = SecurityControl.where(control_id: new_title, security_policy: owner_ref.security_policy).first
    
    if (the_object != nil)
      self.object_id = the_object.id
      self.save
    end
    return self
  end
    
    
    #Returns the url for the related object
    def grab_related_object_url
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
end
