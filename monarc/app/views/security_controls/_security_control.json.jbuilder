json.extract! security_control, :id, :control_id, :Security_Control_Families, :params_id, 
              :name, :title, :type, :priorty, :statements_id, :assessments_id, :objectives, :guidances, :security_policies, :created_at, :updated_at
json.url security_control_url(security_control, format: :json)
