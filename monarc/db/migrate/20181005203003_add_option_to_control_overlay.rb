class AddOptionToControlOverlay < ActiveRecord::Migration[5.2]
  def change
    add_reference :control_overlays, :overlay_field_option, foreign_key: { to_table: :overlay_field_options}
  end
end
