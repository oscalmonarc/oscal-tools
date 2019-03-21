class AddDomainKeyToImpactLevel < ActiveRecord::Migration[5.2]
  def change
    add_reference :impact_levels, :domain_environment
  end
end
