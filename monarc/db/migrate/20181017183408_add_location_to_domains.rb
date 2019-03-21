class AddLocationToDomains < ActiveRecord::Migration[5.2]
  def change
    add_column :domain_environments, :location, :string
  end
end
