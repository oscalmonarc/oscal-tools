class Provider < ApplicationRecord
   acts_as_tree order: "name"
   belongs_to :parent, class_name: "Provider", optional: true
   
   has_many :related_labels, dependent: :destroy
    
   has_many :docs, dependent: :destroy
   has_many :overlays, dependent: :destroy
   has_many :domain_environments, dependent: :destroy
   has_many :components, dependent: :destroy
    
   has_many :control_implementations, dependent: :destroy
   has_many :security_policies, dependent: :destroy
   
   
  def click_link
      link = "<a href='/providers/#{self.id}'>#{self.name}</a>"
      return  link.html_safe
  end
   
  def labels
    tmp_labels = []
      related = self.related_labels
      if has_data? (related)
        related.each do |rel_label|
          label = rel_label.label
          tmp_labels << label
          if (label.parent != nil)
            tmp_labels = grab_tree(label, tmp_labels )
          end 
        end
        tmp_labels = tmp_labels.uniq!
      end
    return tmp_labels
  end
    
end
