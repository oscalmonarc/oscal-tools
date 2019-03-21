class AddParentToDataClassification < ActiveRecord::Migration[5.2]
  def change
    add_reference :data_classifications, :parent, foreign_key: { to_table: :data_classifications}
  end
end
