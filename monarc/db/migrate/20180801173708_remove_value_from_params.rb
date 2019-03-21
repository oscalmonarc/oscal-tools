class RemoveValueFromParams < ActiveRecord::Migration[5.2]
  def change
    remove_column :params, :param_value
  end
end
