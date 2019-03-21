class CreateDataClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :data_classifications do |t|
      t.string :name

      t.timestamps
    end
  end
end
