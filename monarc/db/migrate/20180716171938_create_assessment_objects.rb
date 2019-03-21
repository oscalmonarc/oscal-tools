class CreateAssessmentObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :assessment_objects do |t|
      t.text :description
      t.references :security_control, foreign_key: true
      t.references :requirement, foreign_key: true

      t.timestamps
    end
  end
end
