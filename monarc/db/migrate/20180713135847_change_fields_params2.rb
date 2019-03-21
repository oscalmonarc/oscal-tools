class ChangeFieldsParams2 < ActiveRecord::Migration[5.2]
  def change
    add_reference :params, :security_control, foreign_key: { to_table: :security_controls}
    add_reference :params, :statement, foreign_key: { to_table: :statements}
    add_reference :params, :item, foreign_key: { to_table: :items}
  end
end
