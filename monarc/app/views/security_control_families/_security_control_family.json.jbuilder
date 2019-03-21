json.extract! security_control_family, :id, :abv, :family, :title, :version, :provider, :security_controls_id, 
              :security_policy_id, :security_policies_id, :created_at, :updated_at
json.url security_control_family_url(security_control_family, format: :json)
