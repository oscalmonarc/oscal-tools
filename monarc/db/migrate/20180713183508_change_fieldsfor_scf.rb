class ChangeFieldsforScf < ActiveRecord::Migration[5.2]
  def change
    remove_column :security_control_families, :version
    remove_column :security_control_families, :security_controls_id
    
  end
end
