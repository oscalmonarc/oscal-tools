class CreateAssessments < ActiveRecord::Migration[5.2]
  def change
  #  drop_table :assessments
    create_table :assessments do |t|
      t.string :assesment_id
      t.string :method
      t.references :assesment_objects, foreign_key: true

      t.timestamps
    end
  end
end
