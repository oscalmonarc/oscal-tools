class AddFieldsToControlOverlas < ActiveRecord::Migration[5.2]
  def change
    #add_reference :security_control_overlays, :security_policy, foreign_key: { to_table: :security_policies}
    #add_reference :security_control_overlays, :domain_environment, foreign_key: { to_table: :domain_environments}
    #add_reference :security_control_overlays, :security_control, foreign_key: { to_table: :security_controls}
  end
end
