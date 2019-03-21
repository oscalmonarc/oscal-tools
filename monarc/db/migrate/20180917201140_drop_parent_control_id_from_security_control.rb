class DropParentControlIdFromSecurityControl < ActiveRecord::Migration[5.2]
  def change
    
    remove_reference :security_controls, :parent_control, foreign_key: { to_table: :security_controls}
  end
end
