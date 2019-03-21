json.extract! security_policy, :id, :name, :version, :provider, :requirements_id, :security_controls_id, :security_control_families_id, :created_at, :updated_at
json.url security_policy_url(security_policy, format: :json)
