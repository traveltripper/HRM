json.extract! pollquestion, :id, :question, :status, :created_at, :updated_at
json.url pollquestion_url(pollquestion, format: :json)