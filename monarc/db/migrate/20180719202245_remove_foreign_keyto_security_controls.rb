class RemoveForeignKeytoSecurityControls < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :related_controls, :security_controls
    remove_foreign_key :docs, :security_policies
    remove_foreign_key :objectives, :security_controls
    remove_foreign_key :objectives, :objectives
    remove_foreign_key :objectives, :requirements
    remove_foreign_key :params, :params
    remove_foreign_key :profiles, :security_controls
    remove_foreign_key :profiles, :requirements
    
    
  end
end
