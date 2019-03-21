class AddProviderToRelatedLabel < ActiveRecord::Migration[5.2]
  def change
    add_reference :related_labels, :provier, foreign_key: { to_table: :providers}
  end
end
