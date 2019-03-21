class ChangeFieldsAgainForSecuirtyControls < ActiveRecord::Migration[5.2]
  def change
    remove_column  :security_controls, :security_family_id
    add_reference :security_controls, :security_control_family, index: true
  end
end
