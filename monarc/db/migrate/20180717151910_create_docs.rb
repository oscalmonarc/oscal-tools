class CreateDocs < ActiveRecord::Migration[5.2]
  def change
    create_table :docs do |t|
      t.text :name
      t.text :description
      t.string :type
      t.text :url
      t.text :version
      t.references :security_policy, foreign_key: true

      t.timestamps
    end
  end
end
