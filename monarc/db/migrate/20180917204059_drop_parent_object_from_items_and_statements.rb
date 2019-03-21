class DropParentObjectFromItemsAndStatements < ActiveRecord::Migration[5.2]
  def change
    remove_reference :items, :parent_item, foreign_key: { to_table: :items}
    remove_reference :statements, :parent_statement, foreign_key: { to_table: :statements}
  end
end
