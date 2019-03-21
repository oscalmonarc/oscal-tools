class FixRelatedRefs < ActiveRecord::Migration[5.2]
  def change
    add_column :related_refs, :rel, :string
    add_column :related_refs, :object_type, :string
    add_column :related_refs, :object_id, :string
  end
end
