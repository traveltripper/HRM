json.extract! pollanswer, :id, :pollquestion_id, :option, :status, :created_at, :updated_at
json.url pollanswer_url(pollanswer, format: :json)