class CreateOverlays < ActiveRecord::Migration[5.2]
  def change
    create_table :overlays do |t|
      t.references :provider, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
