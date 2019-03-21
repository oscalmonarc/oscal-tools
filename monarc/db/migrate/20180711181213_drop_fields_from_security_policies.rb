class DropFieldsFromSecurityPolicies < ActiveRecord::Migration[5.2]
  def change
    remove_column  :security_policies, :security_controls_id
    remove_column  :security_policies, :security_control_families_id
    remove_column :security_policies, :requirements_id
  end
end
