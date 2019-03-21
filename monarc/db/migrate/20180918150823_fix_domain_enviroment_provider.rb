class FixDomainEnviromentProvider < ActiveRecord::Migration[5.2]
  def change
    remove_reference :domain_environments, :organization, foreign_key: { to_table: :organizations}
    add_reference :domain_environments, :provider, foreign_key: { to_table: :providers}
    drop_table :organizations
  end
end
