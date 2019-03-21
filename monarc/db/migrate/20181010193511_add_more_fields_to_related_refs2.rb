class AddMoreFieldsToRelatedRefs2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :related_refs, :owner_object, :string
    remove_column :related_refs, :owner_id, :bigint
    
    add_column :related_refs, :owner_object_type, :string
    add_column :related_refs, :owner_object_id, :bigint
  end
end
