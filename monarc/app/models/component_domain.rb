class ComponentDomain < ApplicationRecord
  
  belongs_to :component
  belongs_to :domain_environment
  
  validates_presence_of :component_id, :domain_environment_id
  
  
end
