class AddClassToSecurityFamily < ActiveRecord::Migration[5.2]
  def change
    add_column :security_control_families, :family_class, :string
  end
end
