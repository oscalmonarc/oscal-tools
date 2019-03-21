class CreateRelatedRefs < ActiveRecord::Migration[5.2]
  def change
    create_table :related_refs do |t|
      t.references :requirement, foreign_key: true
      t.references :security_control, foreign_key: true
      t.references :ref, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
