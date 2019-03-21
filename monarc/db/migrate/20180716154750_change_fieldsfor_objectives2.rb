class ChangeFieldsforObjectives2 < ActiveRecord::Migration[5.2]
  def change
    add_reference :objectives, :parent_objective, foreign_key: { to_table: :objectives }
  end
end
