class RemoveForeignKeyFromParams < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :params, :params
    remove_foreign_key :params, :items
    remove_foreign_key :params, :security_controls
    remove_foreign_key :params, :statements
  end
end
