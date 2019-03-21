class DropControlObjectives < ActiveRecord::Migration[5.2]
  def change
    drop_table :control_objectives
  end
end
