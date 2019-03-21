class FixFieldsFromSecurityPolicies < ActiveRecord::Migration[5.2]
  def change
    change_column :security_policies, :security_controls_id, :text
    change_column :security_policies, :security_control_families_id, :text
    change_column :security_policies, :requirements_id, :text
  end
end
