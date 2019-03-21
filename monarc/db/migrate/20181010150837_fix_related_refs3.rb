class FixRelatedRefs3 < ActiveRecord::Migration[5.2]
  def change
    remove_column :related_refs, :object_id, :int
        add_column :related_refs, :object_id, :bigint
  end
end
