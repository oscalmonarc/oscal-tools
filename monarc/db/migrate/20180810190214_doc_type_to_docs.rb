class DocTypeToDocs < ActiveRecord::Migration[5.2]
  def change
    add_column :docs, :doc_type, :string
  end
end
