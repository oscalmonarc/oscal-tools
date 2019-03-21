class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
#    drop_table :requirements
    create_table :requirements do |t|
      t.string :name
      t.references :statements, foreign_key: true
      t.references :guidances, foreign_key: true
      t.references :security_controls, foreign_key: false
      t.references :requirements, foreign_key: false
      t.references :security_policies, foreign_key: false

      t.timestamps
    end
  end
end
