class ChangeFieldsforGuidances < ActiveRecord::Migration[5.2]
  def change
    remove_column :guidances, :info
    remove_column :guidances, :name
    add_column :guidances, :description, :text
    add_reference :guidances, :requirement, foreign_key: { to_table: :requirements }
    add_reference :guidances, :security_control, foreign_key: { to_table: :security_controls }
  end
end
