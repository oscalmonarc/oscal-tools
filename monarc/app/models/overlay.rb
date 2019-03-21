class Overlay < ApplicationRecord
  belongs_to :provider
  has_many :overlay_fields, dependent: :destroy
  has_many :control_overlays, through: :overlay_fields 
  has_many :security_controls, -> { distinct }, through: :control_overlays 
  
  def click_link
      link = "<a href='/overlays/#{self.id}'>#{self.name}</a>"
      return  link.html_safe
  end
  
  
end
