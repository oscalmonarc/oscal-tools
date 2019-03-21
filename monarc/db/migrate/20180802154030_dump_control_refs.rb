class DumpControlRefs < ActiveRecord::Migration[5.2]
  def change
    drop_table :control_refs
  end
end
