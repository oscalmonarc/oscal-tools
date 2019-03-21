class ChangeFieldsforGuidances2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :guidances, :guidance_id
  end
end
