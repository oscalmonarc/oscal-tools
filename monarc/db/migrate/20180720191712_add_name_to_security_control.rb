class AddNameToSecurityControl < ActiveRecord::Migration[5.2]
  def change
    add_column :security_controls, :name, :string
  end
end
