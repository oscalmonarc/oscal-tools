class CreateSecurityControlFamilies < ActiveRecord::Migration[5.2]
  def change
#    drop_table :security_control_families
    create_table :security_control_families do |t|
      t.string :abv
      t.string :family
      t.string :title
      t.string :version
      t.string :org
      t.references :security_controls, foreign_key: false
      t.references :security_policy, foreign_key: false
      t.references :security_policies, foreign_key: false

      t.timestamps
    end
  end
end
