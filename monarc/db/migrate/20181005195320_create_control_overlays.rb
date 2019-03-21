class CreateControlOverlays < ActiveRecord::Migration[5.2]
  def change
    create_table :control_overlays do |t|
      t.references :security_policy, foreign_key: true
      t.references :domain_environment, foreign_key: true
      t.references :overlay_field, foreign_key: true
      t.string :overlay_value
      t.references :security_control, foreign_key: true

      t.timestamps
    end
  end
end
