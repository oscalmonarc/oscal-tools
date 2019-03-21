class CreateParams < ActiveRecord::Migration[5.2]
  def change
    drop_table :params
    create_table :params do |t|
      t.string :params_id
      t.string :label
      t.string :info
      t.string :param_value

      t.timestamps
    end
  end
end
