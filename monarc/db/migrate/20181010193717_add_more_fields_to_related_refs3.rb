class AddMoreFieldsToRelatedRefs3 < ActiveRecord::Migration[5.2]
  def change
    remove_column :related_refs, :title 
    remove_column :related_refs, :updated_at
    remove_column :related_refs, :created_at
    
    add_column :related_refs, :title, :string
    add_column :related_refs, :created_at, :datetime, null: false
    add_column :related_refs, :updated_at, :datetime, null: false
  end
end
