class RemoveForeignKeyFromItems < ActiveRecord::Migration[5.2]
  def change
   remove_foreign_key :items, :statements
    
  end
end
