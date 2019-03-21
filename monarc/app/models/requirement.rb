class Requirement < ApplicationRecord
  has_many :statements,  dependent: :destroy
  has_many :guidances,  dependent: :destroy
  has_many :related_refs, dependent: :destroy
  
  
  belongs_to  :security_policy
  
    
  #returns the url
  def the_url
      return Rails.application.routes.url_helpers.requirement_url(self, only_path: true)
  end
end
