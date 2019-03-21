class DropOrgFromScf < ActiveRecord::Migration[5.2]
  def change
    drop_table :orgs
  end
end
