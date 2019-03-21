# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_15_194928) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assessment_objects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "description"
    t.bigint "security_control_id"
    t.bigint "requirement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assessment_id"
    t.bigint "parent_id"
    t.string "assessment_object_id"
    t.index ["assessment_id"], name: "index_assessment_objects_on_assessment_id"
    t.index ["parent_id"], name: "index_assessment_objects_on_parent_id"
    t.index ["requirement_id"], name: "index_assessment_objects_on_requirement_id"
    t.index ["security_control_id"], name: "index_assessment_objects_on_security_control_id"
  end

  create_table "assessments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "requirement_id"
    t.bigint "security_control_id"
    t.bigint "parent_id"
    t.string "assessment_id"
    t.index ["parent_id"], name: "index_assessments_on_parent_id"
    t.index ["requirement_id"], name: "index_assessments_on_requirement_id"
    t.index ["security_control_id"], name: "index_assessments_on_security_control_id"
  end

  create_table "component_domains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "component_id"
    t.bigint "domain_environment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["component_id"], name: "index_component_domains_on_component_id"
    t.index ["domain_environment_id"], name: "index_component_domains_on_domain_environment_id"
  end

  create_table "components", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "provider_id"
    t.string "name"
    t.string "description"
    t.string "make"
    t.string "model"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_components_on_parent_id"
    t.index ["provider_id"], name: "index_components_on_provider_id"
  end

  create_table "control_implementations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "component_id"
    t.bigint "domain_environment_id"
    t.bigint "provider_id"
    t.bigint "security_control_id"
    t.bigint "security_policy_id"
    t.binary "implementation_method"
    t.boolean "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "inheritied_by_id"
    t.bigint "parent_id"
    t.string "inheritance_type"
    t.bigint "objective_id"
    t.bigint "statement_id"
    t.bigint "item_id"
    t.index ["component_id"], name: "index_control_implementations_on_component_id"
    t.index ["domain_environment_id"], name: "index_control_implementations_on_domain_environment_id"
    t.index ["inheritied_by_id"], name: "index_control_implementations_on_inheritied_by_id"
    t.index ["item_id"], name: "index_control_implementations_on_item_id"
    t.index ["objective_id"], name: "index_control_implementations_on_objective_id"
    t.index ["parent_id"], name: "index_control_implementations_on_parent_id"
    t.index ["provider_id"], name: "index_control_implementations_on_provider_id"
    t.index ["security_control_id"], name: "index_control_implementations_on_security_control_id"
    t.index ["security_policy_id"], name: "index_control_implementations_on_security_policy_id"
    t.index ["statement_id"], name: "index_control_implementations_on_statement_id"
  end

  create_table "control_overlays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "security_policy_id"
    t.bigint "domain_environment_id"
    t.bigint "overlay_field_id"
    t.string "overlay_value"
    t.bigint "security_control_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "overlay_field_option_id"
    t.index ["domain_environment_id"], name: "index_control_overlays_on_domain_environment_id"
    t.index ["overlay_field_id"], name: "index_control_overlays_on_overlay_field_id"
    t.index ["overlay_field_option_id"], name: "index_control_overlays_on_overlay_field_option_id"
    t.index ["security_control_id"], name: "index_control_overlays_on_security_control_id"
    t.index ["security_policy_id"], name: "index_control_overlays_on_security_policy_id"
  end

  create_table "data_classifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_data_classifications_on_parent_id"
  end

  create_table "docs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.text "url"
    t.bigint "security_policy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_type"
    t.string "doc_type"
    t.integer "declarations_id"
    t.datetime "source_date"
    t.datetime "imported"
    t.bigint "provider_id"
    t.index ["declarations_id"], name: "index_docs_on_declarations_id"
    t.index ["provider_id"], name: "index_docs_on_provider_id"
    t.index ["security_policy_id"], name: "index_docs_on_security_policy_id"
  end

  create_table "domain_environments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.bigint "data_classification_id"
    t.bigint "provider_id"
    t.string "region"
    t.string "end_point"
    t.string "location"
    t.index ["data_classification_id"], name: "index_domain_environments_on_data_classification_id"
    t.index ["parent_id"], name: "index_domain_environments_on_parent_id"
    t.index ["provider_id"], name: "index_domain_environments_on_provider_id"
  end

  create_table "guidances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "requirement_id"
    t.bigint "security_control_id"
    t.bigint "parent_id"
    t.string "guidance_id"
    t.index ["parent_id"], name: "index_guidances_on_parent_id"
    t.index ["requirement_id"], name: "index_guidances_on_requirement_id"
    t.index ["security_control_id"], name: "index_guidances_on_security_control_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "statement_id"
    t.string "item_id"
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_items_on_parent_id"
    t.index ["statement_id"], name: "index_items_on_statement_id"
  end

  create_table "labels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_labels_on_parent_id"
  end

  create_table "objectives", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "objective_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "requirement_id"
    t.bigint "security_control_id"
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_objectives_on_parent_id"
    t.index ["requirement_id"], name: "index_objectives_on_requirement_id"
    t.index ["security_control_id"], name: "index_objectives_on_security_control_id"
  end

  create_table "overlay_field_options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "overlay_field_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["overlay_field_id"], name: "index_overlay_field_options_on_overlay_field_id"
  end

  create_table "overlay_fields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "overlay_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["overlay_id"], name: "index_overlay_fields_on_overlay_id"
  end

  create_table "overlays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "provider_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_overlays_on_provider_id"
  end

  create_table "param_values", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "param_id"
    t.bigint "param_value_id"
    t.string "the_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["param_id"], name: "index_param_values_on_param_id"
    t.index ["param_value_id"], name: "index_param_values_on_param_value_id"
  end

  create_table "params", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "params_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.string "description"
    t.bigint "security_control_id"
    t.bigint "statement_id"
    t.bigint "item_id"
    t.string "selection_type"
    t.bigint "depends_on_id"
    t.index ["depends_on_id"], name: "index_params_on_depends_on_id"
    t.index ["item_id"], name: "index_params_on_item_id"
    t.index ["parent_id"], name: "index_params_on_parent_id"
    t.index ["security_control_id"], name: "index_params_on_security_control_id"
    t.index ["statement_id"], name: "index_params_on_statement_id"
  end

  create_table "providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "description"
    t.string "org_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_providers_on_parent_id"
  end

  create_table "refs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ref_id"
    t.string "title"
    t.string "url"
    t.string "document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "related_labels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "label_id"
    t.string "object_type"
    t.bigint "object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "provider_id"
    t.index ["label_id"], name: "index_related_labels_on_label_id"
    t.index ["provider_id"], name: "index_related_labels_on_provider_id"
  end

  create_table "related_refs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "rel"
    t.string "object_type"
    t.bigint "object_id"
    t.string "owner_object_type"
    t.bigint "owner_object_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requirements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "statements_id"
    t.bigint "guidances_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "security_policy_id"
    t.bigint "security_control_id"
    t.index ["guidances_id"], name: "index_requirements_on_guidances_id"
    t.index ["security_control_id"], name: "index_requirements_on_security_control_id"
    t.index ["security_policy_id"], name: "index_requirements_on_security_policy_id"
    t.index ["statements_id"], name: "index_requirements_on_statements_id"
  end

  create_table "security_control_families", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "abv"
    t.string "family"
    t.string "title"
    t.string "org"
    t.bigint "security_policy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "family_class"
    t.index ["security_policy_id"], name: "index_security_control_families_on_security_policy_id"
  end

  create_table "security_controls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "control_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "security_policy_id"
    t.bigint "security_control_family_id"
    t.string "control_class"
    t.string "status"
    t.string "name"
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_security_controls_on_parent_id"
    t.index ["security_control_family_id"], name: "index_security_controls_on_security_control_family_id"
    t.index ["security_policy_id"], name: "index_security_controls_on_security_policy_id"
  end

  create_table "security_policies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.bigint "provider_id"
    t.index ["parent_id"], name: "index_security_policies_on_parent_id"
    t.index ["provider_id"], name: "index_security_policies_on_provider_id"
  end

  create_table "statements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "requirement_id"
    t.bigint "security_control_id"
    t.bigint "parent_id"
    t.string "statement_id"
    t.index ["parent_id"], name: "index_statements_on_parent_id"
    t.index ["requirement_id"], name: "index_statements_on_requirement_id"
    t.index ["security_control_id"], name: "index_statements_on_security_control_id"
  end

  add_foreign_key "component_domains", "components"
  add_foreign_key "component_domains", "domain_environments"
  add_foreign_key "components", "components", column: "parent_id"
  add_foreign_key "components", "providers"
  add_foreign_key "control_implementations", "components"
  add_foreign_key "control_implementations", "control_implementations", column: "inheritied_by_id"
  add_foreign_key "control_implementations", "control_implementations", column: "parent_id"
  add_foreign_key "control_implementations", "domain_environments"
  add_foreign_key "control_implementations", "providers"
  add_foreign_key "control_implementations", "security_controls"
  add_foreign_key "control_implementations", "security_policies"
  add_foreign_key "control_overlays", "domain_environments"
  add_foreign_key "control_overlays", "overlay_field_options"
  add_foreign_key "control_overlays", "overlay_fields"
  add_foreign_key "control_overlays", "security_controls"
  add_foreign_key "control_overlays", "security_policies"
  add_foreign_key "data_classifications", "data_classifications", column: "parent_id"
  add_foreign_key "items", "items", column: "parent_id"
  add_foreign_key "items", "statements", name: "items_statement_id_fk", on_delete: :cascade
  add_foreign_key "labels", "labels", column: "parent_id"
  add_foreign_key "objectives", "objectives", column: "parent_id"
  add_foreign_key "objectives", "requirements", name: "objectives_requirement_id_fk", on_delete: :cascade
  add_foreign_key "objectives", "security_controls", name: "objectives_security_control_id_fk", on_delete: :cascade
  add_foreign_key "overlay_field_options", "overlay_fields"
  add_foreign_key "overlay_fields", "overlays"
  add_foreign_key "overlays", "providers"
  add_foreign_key "param_values", "param_values"
  add_foreign_key "param_values", "params"
  add_foreign_key "params", "items", name: "params_item_id_fk", on_delete: :cascade
  add_foreign_key "params", "params", column: "depends_on_id"
  add_foreign_key "params", "params", column: "parent_id", name: "params_parent_id_fk", on_delete: :cascade
  add_foreign_key "params", "security_controls", name: "params_security_control_id_fk", on_delete: :cascade
  add_foreign_key "params", "statements", name: "params_statement_id_fk", on_delete: :cascade
  add_foreign_key "providers", "providers", column: "parent_id"
  add_foreign_key "related_labels", "labels"
  add_foreign_key "related_labels", "providers"
  add_foreign_key "requirements", "security_controls", name: "requirements_security_control_id_fk", on_delete: :cascade
  add_foreign_key "requirements", "security_policies", name: "requirements_security_policy_id_fk", on_delete: :cascade
  add_foreign_key "security_control_families", "security_policies", name: "security_control_families_security_policy_id_fk", on_delete: :cascade
  add_foreign_key "security_controls", "security_control_families", name: "security_controls_security_control_family_id_fk", on_delete: :cascade
  add_foreign_key "security_controls", "security_controls", column: "parent_id"
  add_foreign_key "security_controls", "security_policies", name: "security_controls_security_policy_id_fk", on_delete: :cascade
  add_foreign_key "security_policies", "providers"
  add_foreign_key "security_policies", "security_policies", column: "parent_id"
  add_foreign_key "statements", "requirements", name: "statements_requirement_id_fk", on_delete: :cascade
  add_foreign_key "statements", "security_controls", name: "statements_security_control_id_fk", on_delete: :cascade
  add_foreign_key "statements", "statements", column: "parent_id"
end
