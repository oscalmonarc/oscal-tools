class ChangeFieldsForRequirements < ActiveRecord::Migration[5.2]
  def change
    
    remove_column :requirements, :security_policies_id
    remove_column :requirements, :requirements_id
    remove_column :requirements, :security_controls_id
    add_reference :requirements, :security_policy, index: true
    add_reference :requirements, :security_control, index: true
  end
end
