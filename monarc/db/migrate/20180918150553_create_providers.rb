class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :location
      t.string :description
      t.string :org_type

      t.timestamps
    end
  end
end
