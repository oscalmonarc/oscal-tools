class AddGudianceIDtoGudiance < ActiveRecord::Migration[5.2]
  def change
    add_column :guidances, :guidance_id, :string
  end
end
