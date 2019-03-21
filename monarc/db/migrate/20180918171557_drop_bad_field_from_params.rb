class DropBadFieldFromParams < ActiveRecord::Migration[5.2]
  def change
    remove_column :params, :security_controls_id
    remove_column :params, :statements_id
    remove_column :params, :items_id
    remove_column :params, :depends_on_id
  end
end
