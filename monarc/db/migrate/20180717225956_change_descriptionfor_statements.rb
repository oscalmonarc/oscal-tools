class ChangeDescriptionforStatements < ActiveRecord::Migration[5.2]
  def change
    change_column :statements, :description, :text
  end
end
