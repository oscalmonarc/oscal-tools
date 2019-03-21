class RemoveForeignKeyFromSecurityControlsPoliciesandFamilies < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :security_controls, :security_controls
    
    
  end
end
