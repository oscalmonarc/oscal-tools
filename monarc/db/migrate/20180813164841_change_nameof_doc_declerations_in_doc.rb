class ChangeNameofDocDeclerationsInDoc < ActiveRecord::Migration[5.2]
  def change
    rename_column :docs, :declerations_id, :declarations_id
  end
end
