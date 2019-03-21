class ChangeFieldsforRelatedControls < ActiveRecord::Migration[5.2]
  def change
    remove_column :related_controls, :relatedcontrol
    add_column :related_controls, :related_control_id, :string
  end
end
