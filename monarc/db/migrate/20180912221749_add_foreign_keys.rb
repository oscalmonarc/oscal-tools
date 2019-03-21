class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key "assessment_objects", "assessments", name: "assessment_objects_assessment_id_fk", on_delete: :cascade
    add_foreign_key "assessment_objects", "requirements", name: "assessment_objects_requirement_id_fk", on_delete: :cascade
    add_foreign_key "assessment_objects", "security_controls", name: "assessment_objects_security_control_id_fk", on_delete: :cascade
    add_foreign_key "assessments", "requirements", name: "assessments_requirement_id_fk", on_delete: :cascade
    add_foreign_key "assessments", "security_controls", name: "assessments_security_control_id_fk", on_delete: :cascade
    add_foreign_key "docs", "security_policies", name: "docs_security_policy_id_fk", on_delete: :cascade
    add_foreign_key "guidances", "requirements", name: "guidances_requirement_id_fk", on_delete: :cascade
    add_foreign_key "guidances", "security_controls", name: "guidances_security_control_id_fk", on_delete: :cascade
    add_foreign_key "impact_levels", "profiles", name: "impact_levels_profile_id_fk", on_delete: :cascade
    add_foreign_key "impact_levels", "security_controls", name: "impact_levels_security_control_id_fk", on_delete: :cascade
    add_foreign_key "impact_levels", "security_policies", name: "impact_levels_security_policy_id_fk", on_delete: :cascade
    add_foreign_key "items", "items", column: "parent_item_id", name: "items_parent_item_id_fk", on_delete: :cascade
    add_foreign_key "items", "statements", name: "items_statement_id_fk", on_delete: :cascade
    add_foreign_key "objectives", "objectives", column: "parent_objective_id", name: "objectives_parent_objective_id_fk", on_delete: :cascade
    add_foreign_key "objectives", "requirements", name: "objectives_requirement_id_fk", on_delete: :cascade
    add_foreign_key "objectives", "security_controls", name: "objectives_security_control_id_fk", on_delete: :cascade
    add_foreign_key "params", "items", name: "params_item_id_fk", on_delete: :cascade
    add_foreign_key "params", "params", column: "parent_id", name: "params_parent_id_fk", on_delete: :cascade
    add_foreign_key "params", "security_controls", name: "params_security_control_id_fk", on_delete: :cascade
    add_foreign_key "params", "statements", name: "params_statement_id_fk", on_delete: :cascade
    add_foreign_key "related_controls", "security_controls", name: "related_controls_security_control_id_fk", on_delete: :cascade
    add_foreign_key "related_refs", "refs", name: "related_refs_ref_id_fk", on_delete: :cascade
    add_foreign_key "requirements", "security_controls", name: "requirements_security_control_id_fk", on_delete: :cascade
    add_foreign_key "requirements", "security_policies", name: "requirements_security_policy_id_fk", on_delete: :cascade
    add_foreign_key "security_control_families", "security_policies", name: "security_control_families_security_policy_id_fk", on_delete: :cascade
    add_foreign_key "security_controls", "security_controls", column: "parent_control_id", name: "security_controls_parent_control_id_fk", on_delete: :cascade
    add_foreign_key "security_controls", "security_control_families", name: "security_controls_security_control_family_id_fk", on_delete: :cascade
    add_foreign_key "security_controls", "security_policies", name: "security_controls_security_policy_id_fk", on_delete: :cascade
    add_foreign_key "statements", "statements", column: "parent_statement_id", name: "statements_parent_statement_id_fk", on_delete: :cascade
    add_foreign_key "statements", "requirements", name: "statements_requirement_id_fk", on_delete: :cascade
    add_foreign_key "statements", "security_controls", name: "statements_security_control_id_fk", on_delete: :cascade
  end
end
