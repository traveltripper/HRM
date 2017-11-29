json.extract! poll, :id, :employee_id, :pollanswer_id, :created_at, :updated_at
json.url poll_url(poll, format: :json)