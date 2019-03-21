class DocDeclerationsToDoc < ActiveRecord::Migration[5.2]
  def change
    add_column :docs, :declerations_id, :integer
    add_index :docs, :declerations_id
  end
end
