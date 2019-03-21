class CreateOverlayFieldOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :overlay_field_options do |t|
      t.references :overlay_field, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
