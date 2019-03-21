class DomainEnvironment < ApplicationRecord
  acts_as_tree order: "name"
  
  belongs_to :parent, class_name: "DomainEnvironment", optional: true
  
  
  has_many :control_implementations, dependent: :destroy
  has_many :control_overlays, dependent: :destroy
  has_many :component_domains, dependent: :destroy
  
  
  belongs_to :provider
  belongs_to :data_classification, optional: true
  before_destroy :destroy_the_children
  
  
  attr_accessor :confidentiality, :integrity, :availability
  
  #returns the children as subdomains 
  def sub_domains 
     self.children
  end

  def click_link
        link = "<a href='/domain_environments/#{self.id}'>#{self.name}</a>"
        return  link.html_safe
    end
  
end
