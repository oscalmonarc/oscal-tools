class AddFieldsToSecurityControlFamilies < ActiveRecord::Migration[5.2]
  def change
    remove_column :security_control_families, :security_policies_id
    
    
  end
end
