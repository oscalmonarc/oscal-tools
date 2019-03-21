class AddFieldsToParams < ActiveRecord::Migration[5.2]
  def change
    remove_column :params, :label
    add_column :params, :selection_type, :string
  end
end
