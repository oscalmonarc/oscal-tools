class CreateSecurityPolicies < ActiveRecord::Migration[5.2]
  def change
#    drop_table :security_policies
    create_table :security_policies do |t|
      t.string :name
      t.string :version
      t.string :org
      t.references :requirements, foreign_key: true
      t.references :security_controls, foreign_key: true
      t.references :security_control_families, foreign_key: true

      t.timestamps
    end
  end
end
