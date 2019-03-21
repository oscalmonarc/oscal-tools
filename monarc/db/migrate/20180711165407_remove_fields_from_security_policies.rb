class RemoveFieldsFromSecurityPolicies < ActiveRecord::Migration[5.2]
  def change
    
    #remove_foreign_key :security_policies, name: "fk_rails_62a21c8dbc"
    #remove_foreign_key :security_policies, name: "fk_rails_1d2ec8ffd5"
    #remove_foreign_key :security_policies, name: "fk_rails_37782118b2"
    remove_index :security_policies, name: "index_security_policies_on_requirements_id"
    remove_index :security_policies, name: "index_security_policies_on_security_controls_id"
    remove_index :security_policies, name: "index_security_policies_on_security_control_families_id"
    change_column :security_policies, :security_controls_id, :blob
    change_column :security_policies, :security_control_families_id, :blob
    change_column :security_policies, :requirements_id, :blob
    
  end
end
