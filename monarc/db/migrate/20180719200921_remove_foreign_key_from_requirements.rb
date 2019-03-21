class RemoveForeignKeyFromRequirements < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :requirements, :guidances
    remove_foreign_key :requirements, :statements
  end
end
