class ChangeFieldsforItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :info
    remove_column :items, :items_id
    add_reference :items, :parent_item
  end
end
