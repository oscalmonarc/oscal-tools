class CreateRelatedLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :related_labels do |t|
      t.references :label, foreign_key: true
      t.string :object_type
      t.bigint :object_id

      t.timestamps
    end
  end
end
