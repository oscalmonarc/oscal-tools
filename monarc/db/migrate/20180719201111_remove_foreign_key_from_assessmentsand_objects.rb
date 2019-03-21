class RemoveForeignKeyFromAssessmentsandObjects < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :assessments, :requirements
    remove_foreign_key :assessments, :security_controls

    remove_foreign_key :assessment_objects, :security_controls
    remove_foreign_key :assessment_objects, :requirements
    remove_foreign_key :assessment_objects, :assessments
    
    
  end
end
