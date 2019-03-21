class AddFieldsParams < ActiveRecord::Migration[5.2]
  def change
    add_reference :params, :security_controls
    add_reference :params, :statements
    add_reference :params, :items
    add_reference :params, :depends_on, foreign_key: { to_table: :params}
    add_reference :params, :parent, foreign_key: { to_table: :params}
  end
end
