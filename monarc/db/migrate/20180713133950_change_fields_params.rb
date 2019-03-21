class ChangeFieldsParams < ActiveRecord::Migration[5.2]
  def change
    remove_column :params, :info
    add_column :params, :description, :string
  end
end
