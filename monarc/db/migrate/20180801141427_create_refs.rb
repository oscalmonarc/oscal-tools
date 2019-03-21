class CreateRefs < ActiveRecord::Migration[5.2]
  def change
    create_table :refs do |t|
      t.string :ref_id
      t.string :title
      t.string :url
      t.string :document

      t.timestamps
    end
  end
end
