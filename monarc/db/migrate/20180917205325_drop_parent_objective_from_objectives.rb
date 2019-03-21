class DropParentObjectiveFromObjectives < ActiveRecord::Migration[5.2]
  def change
    remove_reference :objectives, :parent_objective, foreign_key: { to_table: :objectives}
  end
end
