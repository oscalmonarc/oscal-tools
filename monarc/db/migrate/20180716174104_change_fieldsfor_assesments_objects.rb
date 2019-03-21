class ChangeFieldsforAssesmentsObjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :assessment_objects, :assessment, foreign_key: { to_table: :assessments }
  end
end
