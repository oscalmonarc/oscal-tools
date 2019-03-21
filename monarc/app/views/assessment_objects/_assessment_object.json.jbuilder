json.extract! assessment_object, :id, :description, :security_control_id, :requirement_id, :created_at, :updated_at
json.url assessment_object_url(assessment_object, format: :json)
