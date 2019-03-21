class AddProviderToImpactLevels < ActiveRecord::Migration[5.2]
  def change
    add_reference :impact_levels, :provider
    remove_reference :impact_levels, :organization
  end
end
