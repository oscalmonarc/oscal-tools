class ChangeFieldsforStatements < ActiveRecord::Migration[5.2]
  def change
    
    remove_column :statements, :items_id
    remove_column :statements, :params_id
    remove_column :statements, :name
    remove_column :statements, :info
    add_column    :statements, :description, :string
    add_reference :statements, :parent_statement, foreign_key: { to_table: :statements }
    add_reference :statements, :requirement, foreign_key: { to_table: :requirements }
    add_reference :statements, :security_control, foreign_key: { to_table: :security_controls }
      
  end
end
