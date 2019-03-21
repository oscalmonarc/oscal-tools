class AddProviderToSecurityPolicy < ActiveRecord::Migration[5.2]
  def change
    add_reference :security_policies, :provider, foreign_key: { to_table: :providers}
    remove_column :security_policies, :org
    
  end
end
