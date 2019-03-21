class ChangeFieldsforStatements2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :statements, :statement_id
  end
end
