class FixImpactLevelLengthOfCiaValues < ActiveRecord::Migration[5.2]
  def change
  	change_column :impact_levels, :confidentiality, :string, :limit => 10 
    change_column :impact_levels, :integrity, :string, :limit => 10
    change_column :impact_levels, :availability, :string, :limit => 10
     
  end
end
