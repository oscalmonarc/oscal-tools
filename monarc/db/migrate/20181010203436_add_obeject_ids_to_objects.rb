class AddObejectIdsToObjects < ActiveRecord::Migration[5.2]
  def change
    add_column :statements, :statement_id, :string
    add_column :assessments, :assessment_id, :string
    add_column :assessment_objects, :assessment_object_id, :string
  end
end
