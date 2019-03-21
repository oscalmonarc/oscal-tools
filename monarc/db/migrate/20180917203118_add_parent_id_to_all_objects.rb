class AddParentIdToAllObjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :assessments, :parent, foreign_key: { to_table: :assessments}
    add_reference :assessment_objects, :parent, foreign_key: { to_table: :assessment_objects}
    add_reference :guidances, :parent, foreign_key: { to_table: :guidances }
    add_reference :items, :parent, foreign_key: { to_table: :items }
    add_reference :objectives, :parent, foreign_key: { to_table: :objectives }
    add_reference :security_policies, :parent, foreign_key: { to_table: :security_policies }
    add_reference :statements, :parent, foreign_key: { to_table: :statements}
      
      
  end
end
