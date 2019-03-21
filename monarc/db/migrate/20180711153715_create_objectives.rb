class CreateObjectives < ActiveRecord::Migration[5.2]
  def change
#    drop_table :objectives
    create_table :objectives do |t|
      t.string :objective_id
      t.string :name
      t.string :info

      t.timestamps
    end
  end
end
