class CreateComponents < ActiveRecord::Migration[5.2]
  def change
    create_table :components do |t|
      t.references :provider, foreign_key: true
      t.references :component_type, foreign_key: true
      t.string :name
      t.string :description
      t.string :make
      t.string :model
      t.string :version

      t.timestamps
    end
  end
end
