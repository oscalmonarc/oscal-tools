class CreateOverlayFields < ActiveRecord::Migration[5.2]
  def change
    create_table :overlay_fields do |t|
      t.references :overlay, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
