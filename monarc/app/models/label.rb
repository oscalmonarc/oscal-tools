class Label < ApplicationRecord
  acts_as_tree order: "name"
  validates_presence_of :name
  
  belongs_to :parent, class_name: "Label", optional: true
  
  has_many :related_labels, dependent: :destroy
  
  before_destroy :destroy_the_children
  
  
  
  def click_link
        link = "<a href='/labels/#{self.id}'>#{self.name}</a>"
        return  link.html_safe
  end
  
  def component_count
    childen_labels = self.children
    count = 0
    components = self.components
    if (components != nil)
      count = count + components.count 
    end  

    if has_data?(childen_labels)
      childen_labels.each do |label|
        count = count + label.component_count
      end
    end
    return count
  end
  
  def provider_components_count(provider)
    components = provider_components(provider)
    count = 0
    if has_data?(components)
      count = components.count
    end
    return count
  end
  
  def grab_related(object_type) 
    related = RelatedLabel.where(object_type: object_type, label: self)
    if has_data?(related)
      return related
    else
      return nil
    end
  end
  
  def grab_related_by_provider(object_type, provider) 
      related = RelatedLabel.where(object_type: object_type, label: self, provider: provider)
      if has_data?(related)
        return related
      else
        return nil
      end
    end
  
  def components
    components = []
    related = self.grab_related("component")
    if has_data?(related)
      related.each do |tmp_comp|
        component = Component.find(tmp_comp.object_id)
        if has_data?(component)
          components << component
        end
      end
    end
    if has_data?(components)
      return components 
    else
      return nil
    end
  end
  
  def self.category_labels_only(labels)
    categories = []
    if (labels != nil) && (labels.count >0)
      labels.each do |label|
        if(label.top_parent(label).name == "Categories")
           categories << label      
        end
      end
      return categories
    else
      return nil 
    end
  end
  
  def provider_components(provider)
    components = []
    related = self.grab_related_by_provider("component", provider)
    if has_data?(related)
      related.each do |tmp_comp|
        component = Component.find(tmp_comp.object_id)
        if has_data?(component)
          components << component
        end
      end
    end
    if has_data?(components)
      return components 
    else
      return nil
    end
  end
  
  
  
end
