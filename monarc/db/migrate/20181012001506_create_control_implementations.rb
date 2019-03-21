class CreateControlImplementations < ActiveRecord::Migration[5.2]
  def change
    create_table :control_implementations do |t|
      t.references :component, foreign_key: true
      t.references :domain_environment, foreign_key: true
      t.references :provider, foreign_key: true
      t.references :security_control, foreign_key: true
      t.references :security_policy, foreign_key: true
      t.string :responsibility
      t.blob :implementation_method
      t.boolean :required

      t.timestamps
    end
  end
end
