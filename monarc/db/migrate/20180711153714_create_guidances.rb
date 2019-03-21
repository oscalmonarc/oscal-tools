class CreateGuidances < ActiveRecord::Migration[5.2]
  def change
#    drop_table :guidances
    create_table :guidances do |t|
      t.string :guidance_id
      t.string :name
      t.string :info

      t.timestamps
    end
  end
end
