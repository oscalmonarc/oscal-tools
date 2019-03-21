class AddStatementsAndObjectivesToControlImplementations < ActiveRecord::Migration[5.2]
  def change
    add_reference :control_implementations, :objectives
    add_reference :control_implementations, :statements
    add_reference :control_implementations, :items
  end
end
