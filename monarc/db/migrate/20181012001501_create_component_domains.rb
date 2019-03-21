class CreateComponentDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :component_domains do |t|
      t.references :component, foreign_key: true
      t.references :domain_environment, foreign_key: true

      t.timestamps
    end
  end
end
