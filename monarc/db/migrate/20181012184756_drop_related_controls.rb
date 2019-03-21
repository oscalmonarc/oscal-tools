class DropRelatedControls < ActiveRecord::Migration[5.2]
  def change
    drop_table :related_controls
  end
end
