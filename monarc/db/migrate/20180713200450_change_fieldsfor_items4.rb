class ChangeFieldsforItems4 < ActiveRecord::Migration[5.2]
  def change
    add_column    :items, :item_id, :string
  end
end
