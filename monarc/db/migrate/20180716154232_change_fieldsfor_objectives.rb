class ChangeFieldsforObjectives < ActiveRecord::Migration[5.2]
  def change
    remove_column :objectives, :info
    add_column :objectives, :description, :text
    add_reference :objectives, :requirement, foreign_key: { to_table: :requirements }
    add_reference :objectives, :security_control, foreign_key: { to_table: :security_controls }
  end
end
