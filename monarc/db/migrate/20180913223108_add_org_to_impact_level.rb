class AddOrgToImpactLevel < ActiveRecord::Migration[5.2]
  def change
    add_reference :impact_levels, :organization
  end
end
