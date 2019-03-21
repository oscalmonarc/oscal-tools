class RemoveComponentTypes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :components, :component_type, foreign_key: { to_table: :component_types}
    drop_table :component_types
  end
end
