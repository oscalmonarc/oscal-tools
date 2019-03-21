class FixProviderToRelatedLabel < ActiveRecord::Migration[5.2]
  def change
    
    remove_reference :related_labels, :provier, foreign_key: { to_table: :providers}
    add_reference :related_labels, :provider, foreign_key: { to_table: :providers}
  end
end
