class AddDependsOnToParams < ActiveRecord::Migration[5.2]
  def change
    add_reference :params, :depends_on, foreign_key: { to_table: :params}
  end
end
