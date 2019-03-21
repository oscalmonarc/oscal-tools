json.extract! doc, :id, :name, :description, :type, :url, :version, :security_policy_id, :created_at, :updated_at
json.url doc_url(doc, format: :json)
