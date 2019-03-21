  class AddFieldsToSecurityControls2 < ActiveRecord::Migration[5.2]
  def change
    remove_column  :security_controls, :name
    remove_column  :security_controls, :type
    remove_column  :security_controls, :priorty
    remove_column  :security_controls, :params_id
    remove_column  :security_controls, :objectives_id
    remove_column  :security_controls, :guidances_id
    remove_column  :security_controls, :statements_id
    remove_column  :security_controls, :assessments_id
    
    add_column :security_controls, :control_class, :string
    add_column :security_controls, :status, :string
    add_reference :security_controls, :parent_control, foreign_key: { to_table: :security_controls }
    
    
  end
end
