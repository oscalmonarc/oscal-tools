class ChangeFieldsforRelatedControls2 < ActiveRecord::Migration[5.2]
  def change
    add_column :related_controls, :policy_name, :string
    add_column :related_controls, :version, :string
    add_column :related_controls, :external , :string
  end
end
