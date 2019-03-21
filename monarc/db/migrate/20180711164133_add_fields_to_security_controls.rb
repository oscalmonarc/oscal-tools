class AddFieldsToSecurityControls < ActiveRecord::Migration[5.2]
  def change
    remove_column :security_controls, :security_policies_id
    add_reference :security_controls, :security_policy, index: true
    
        
  end
end
