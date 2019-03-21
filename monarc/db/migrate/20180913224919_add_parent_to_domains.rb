class AddParentToDomains < ActiveRecord::Migration[5.2]
  def change
    add_reference :domain_environments, :parent, foreign_key: { to_table: :domain_environments}
  end
end
