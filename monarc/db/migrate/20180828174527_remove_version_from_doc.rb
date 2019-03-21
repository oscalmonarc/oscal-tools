class RemoveVersionFromDoc < ActiveRecord::Migration[5.2]
  def change
    remove_column :docs, :version
  end
end
