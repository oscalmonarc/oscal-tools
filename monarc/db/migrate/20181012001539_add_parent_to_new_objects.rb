class AddParentToNewObjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :component_types, :parent, foreign_key: { to_table: :component_types}
    add_reference :components, :parent, foreign_key: { to_table: :components}
    add_reference :control_implementations, :inheritied_by, foreign_key: { to_table: :control_implementations}
  end
end
