class RemoveProfileRefs < ActiveRecord::Migration[5.2]
  def change
    remove_reference :impact_levels, :profile
    drop_table :profiles
  end
end
