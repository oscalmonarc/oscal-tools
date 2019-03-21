class AddMoreFieldsToRelatedRefs < ActiveRecord::Migration[5.2]
  def change
    remove_reference :related_refs, :ref 
    remove_reference :related_refs, :security_control
    remove_reference :related_refs, :requirement
    add_column :related_refs, :owner_object, :string
    add_column :related_refs, :owner_id, :bigint
  end
end
