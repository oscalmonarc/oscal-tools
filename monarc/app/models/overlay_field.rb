class OverlayField < ApplicationRecord
  belongs_to :overlay
  has_many :control_overlays, dependent: :destroy
  has_many :overlay_field_options, dependent: :destroy 
  
  def click_link
    link = "<a href='/overlay_fields/#{self.id}'>#{self.name}</a>"
    return  link.html_safe
  end
  
  def select_options
    overlay_field_options = nil
    if (self.overlay_field_options != nil)
      overlay_field_options = self.overlay_field_options.map { |option| [option.name , option.id] }
      overlay_field_options.insert(0,nil)
    end
    return overlay_field_options 
  end
  
  def full_name
    select_option = "#{self.overlay.name}---#{self.name}"
    select_option = select_option.gsub " ", "_"
    select_option = select_option.downcase
    return select_option
  end
  
end
