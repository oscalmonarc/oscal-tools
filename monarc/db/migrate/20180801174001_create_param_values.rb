class CreateParamValues < ActiveRecord::Migration[5.2]
  def change
    create_table :param_values do |t|
      t.references :param, foreign_key: true
      t.references :param_value, foreign_key: true
      t.string :the_value

      t.timestamps
    end
  end
end
