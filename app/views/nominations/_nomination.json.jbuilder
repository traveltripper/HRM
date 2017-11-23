json.extract! nomination, :id, :type, :name, :employee_id, :created_at, :updated_at
json.url nomination_url(nomination, format: :json)