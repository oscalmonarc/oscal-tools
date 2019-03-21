class AddDateandLastImportedFiledtoDocs < ActiveRecord::Migration[5.2]
  def change
    add_column :docs, :source_date, :datetime 
    add_column :docs, :imported, :datetime
  end
end
