class Component < ApplicationRecord
  acts_as_tree order: "name"
  
  belongs_to :parent, class_name: "Component", optional: true   
  belongs_to :provider
  has_many :component_domains, dependent: :destroy
  has_many :control_implementations, dependent: :destroy
  
  validates_presence_of :name
  
  before_destroy :clean_up
  
  def clean_up
    RelatedRef.clean_references_before_destory(self)
  end
  
  def click_link
      link = "<a href='/components/#{self.id}'>#{self.name}</a>"
      return  link.html_safe
  end
  
  
  def labels_click_link
    links = ""
    labels = self.labels
    if has_data?(labels)
      labels.each do |related_label|
        links = links + "#{related_label.label.click_link} - #{related_label.destory_link(related_label)}"
      end
    end
    return links.html_safe
  end
  
  def set_component_label
    if (self.label != nil)
      tmpLabel = Label.find_or_create_by(name: self.label)
      related_label = RelatedLabel.set_related_label(tmpLabel.name, nil, self)
    end
     
  end
  
  
  def show_implemented_controls
    controls = []
    implementations = self.control_implementations
    if has_data?(controls)
      return controls
    else
      return nil
    end
     
  end
  
  
end
