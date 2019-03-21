class AddParentsToLablesAndRelatedLables < ActiveRecord::Migration[5.2]
  def change
    add_reference :labels, :parent, foreign_key: { to_table: :labels}
    
  end
end
