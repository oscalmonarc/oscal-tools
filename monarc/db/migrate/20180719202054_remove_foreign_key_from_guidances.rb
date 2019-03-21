class RemoveForeignKeyFromGuidances < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :guidances, :security_controls
    remove_foreign_key :guidances, :requirements
  end
end
