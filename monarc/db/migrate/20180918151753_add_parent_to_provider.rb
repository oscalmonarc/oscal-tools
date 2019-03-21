class AddParentToProvider < ActiveRecord::Migration[5.2]
  def change
    add_reference :providers, :parent, foreign_key: { to_table: :providers}
  end
end
