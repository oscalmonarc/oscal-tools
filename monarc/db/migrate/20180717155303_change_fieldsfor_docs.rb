class ChangeFieldsforDocs < ActiveRecord::Migration[5.2]
  def change
    remove_column :docs, :type
    add_column :docs, :file_type, :string
  end
end
