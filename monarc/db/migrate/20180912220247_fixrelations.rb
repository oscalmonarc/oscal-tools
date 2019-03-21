class Fixrelations < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :impact_levels, :profiles
    remove_foreign_key :impact_levels, :security_controls
    remove_foreign_key :related_refs, :refs
  end
end
