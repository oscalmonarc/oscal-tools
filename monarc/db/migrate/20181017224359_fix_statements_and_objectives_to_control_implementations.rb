class FixStatementsAndObjectivesToControlImplementations < ActiveRecord::Migration[5.2]
  def change
    remove_reference :control_implementations, :objectives
    remove_reference :control_implementations, :statements
    remove_reference :control_implementations, :items
    
    add_reference :control_implementations, :objective
    add_reference :control_implementations, :statement
    add_reference :control_implementations, :item
  end
end
