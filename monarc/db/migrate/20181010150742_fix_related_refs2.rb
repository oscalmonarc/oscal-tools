class FixRelatedRefs2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :related_refs, :object_id, :string
    add_column :related_refs, :object_id, :int
  end
end
