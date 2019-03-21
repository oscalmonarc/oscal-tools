class CreateDomainEnvironments < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_environments do |t|
      t.string :name
      t.string :description
      t.string :data_classification
      t.belongs_to :organization, foreign_key: true

      t.timestamps
    end
  end
end
