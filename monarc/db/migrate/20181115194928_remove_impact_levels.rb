class RemoveImpactLevels < ActiveRecord::Migration[5.2]
  def change
    drop_table :impact_levels
  end
end
