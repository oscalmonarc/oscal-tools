class AddParentIdSecurityControl < ActiveRecord::Migration[5.2]
  def change
    add_reference :security_controls, :parent, foreign_key: { to_table: :security_controls}
    
  end
end
