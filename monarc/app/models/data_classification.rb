class DataClassification < ApplicationRecord
  acts_as_tree order: "name"
  
  belongs_to :parent, class_name: "DataClassification", optional: true
  has_many :domain_enviroments
  
  validates_presence_of :name
  
  
end
