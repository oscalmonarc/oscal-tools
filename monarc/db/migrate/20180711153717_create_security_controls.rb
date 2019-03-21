class CreateSecurityControls < ActiveRecord::Migration[5.2]
  def change
#    drop_table :security_controls
    create_table :security_controls do |t|
      t.string :control_id
      t.string :name
      t.string :title
      t.string :type
      t.string :priorty
      t.references :params, foreign_key: true
      t.references :objectives, foreign_key: true
      t.references :guidances, foreign_key: true
      t.references :statements, foreign_key: true
      t.references :assessments, foreign_key: true
      t.references :security_control_families, foreign_key: false
      t.references :security_policies, foreign_key: false

      t.timestamps
    end
  end
end
