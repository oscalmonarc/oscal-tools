class RecreateFieldsForImpactLevel < ActiveRecord::Migration[5.2]
  def change
    remove_column :impact_levels, :confidentiality
    remove_column :impact_levels, :integrity
    remove_column :impact_levels, :availability
    add_reference :impact_levels, :security_policy, index: true
    add_column :impact_levels, :c_high, :string, :limit => 4
    add_column :impact_levels, :c_low, :string, :limit => 4
    add_column :impact_levels, :c_mod, :string, :limit => 4
    add_column :impact_levels, :i_high, :string, :limit => 4
    add_column :impact_levels, :i_low, :string, :limit => 4
    add_column :impact_levels, :i_mod, :string, :limit => 4
    add_column :impact_levels, :a_high, :string, :limit => 4
    add_column :impact_levels, :a_low, :string, :limit => 4
    add_column :impact_levels, :a_mod, :string, :limit => 4
          
  end
end
