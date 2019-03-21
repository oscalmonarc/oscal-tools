class CreateItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :items 
    create_table :items do |t|
      t.string :items_id
      t.string :info
      t.string :name

      t.timestamps
    end
  end
end
