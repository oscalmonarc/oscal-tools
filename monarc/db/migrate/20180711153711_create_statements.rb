class CreateStatements < ActiveRecord::Migration[5.2]
  def change
    drop_table :statements
    create_table :statements do |t|
      t.string :statement_id
      t.references :params, foreign_key: true
      t.string :name
      t.string :info
      t.references :items, foreign_key: true

      t.timestamps
    end
  end
end
