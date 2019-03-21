class RemoveForeignKeyFromStatements < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :statements, :security_controls
    remove_foreign_key :statements, :statements
    remove_foreign_key :statements, :requirements
  end
end
