class OverlayFieldOption < ApplicationRecord
  
  belongs_to :overlay_field
  has_many :control_overlays, dependent: :destroy
  
  def click_link
      link = "<a href='/overlay_field_options/#{self.id}'>#{self.name}</a>"
      return  link.html_safe
    end
    
  def self.set_overlay_option(overlay_field, overlay_option)
    option = nil
    if (overlay_option != nil)
      option  = OverlayFieldOption.find_or_create_by(overlay_field: overlay_field, name: overlay_option)
    end
    return option 
  end
  

end
