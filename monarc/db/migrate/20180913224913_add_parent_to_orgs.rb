class AddParentToOrgs < ActiveRecord::Migration[5.2]
  def change
    add_reference :organizations, :parent, foreign_key: { to_table: :organizations}
  end
end
