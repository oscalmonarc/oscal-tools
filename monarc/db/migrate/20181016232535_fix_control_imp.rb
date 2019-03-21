class FixControlImp < ActiveRecord::Migration[5.2]
  def change
    add_reference :control_implementations, :parent, foreign_key: { to_table: :control_implementations}
    remove_column :control_implementations, :responsibility
    add_column :control_implementations, :inheritance_type, :string
      
  end
end
