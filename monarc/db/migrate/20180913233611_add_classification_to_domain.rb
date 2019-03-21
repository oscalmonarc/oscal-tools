class AddClassificationToDomain < ActiveRecord::Migration[5.2]
  def change
    remove_column :domain_environments, :data_classification
    add_reference :domain_environments , :data_classification
  end
end
