class AddRegionsAndEndpointsToDomains < ActiveRecord::Migration[5.2]
  def change
  
  add_column :domain_environments, :region, :string  
  add_column :domain_environments, :end_point, :string
    
    
  end
end
