class ChangeFieldsforItems3 < ActiveRecord::Migration[5.2]
  def change
    add_column    :items, :description, :string
    remove_reference :items, :statements 
    add_reference :items, :statement, foreign_key: { to_table: :statements }
  end
end
