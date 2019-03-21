class DropExternalFromRelatedControls < ActiveRecord::Migration[5.2]
  def change
    remove_column :related_controls, :external
  end
end
