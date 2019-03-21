class AddTypeToRelatedControl < ActiveRecord::Migration[5.2]
  def change
    add_column :related_controls, :rel, :string
  end
end
