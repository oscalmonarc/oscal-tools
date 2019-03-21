class AddProviderToDocs < ActiveRecord::Migration[5.2]
  def change
    add_reference :docs, :provider, foreign_key: { to_table: :providers}
  end
end
