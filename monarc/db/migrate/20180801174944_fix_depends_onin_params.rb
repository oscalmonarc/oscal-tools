class FixDependsOninParams < ActiveRecord::Migration[5.2]
  def change
    change_column :params, :depends_on_id, :string
    
  end
end
