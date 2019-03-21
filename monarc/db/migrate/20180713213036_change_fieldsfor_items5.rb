class ChangeFieldsforItems5 < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :description, :text
  end
end
