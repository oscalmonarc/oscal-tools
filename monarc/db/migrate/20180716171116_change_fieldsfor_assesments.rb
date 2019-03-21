class ChangeFieldsforAssesments < ActiveRecord::Migration[5.2]
  def change
    remove_column :assessments, :assesment_id
    remove_column :assessments, :assesment_objects_id
    add_reference :assessments, :requirement, foreign_key: { to_table: :requirements }
    add_reference :assessments, :security_control, foreign_key: { to_table: :security_controls }
  end
end
