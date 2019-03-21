class AssessmentObject < ApplicationRecord
  acts_as_tree order: "id"
  belongs_to :parent, class_name: "AssessmentObject", optional: true
  belongs_to :security_control, optional: true
  belongs_to :requirement, optional: true
  belongs_to :assessment
  has_many_attached :files
  
  before_destroy :destroy_the_children
  validates_presence_of :description, :assessment_id
  
  
  #Grabs the security control tied to the assessment
  def security_control
      return self.assessment.security_control
  end
  
end
