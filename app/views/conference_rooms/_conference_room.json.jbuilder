json.extract! conference_room, :id, :name, :available, :created_at, :updated_at
json.url conference_room_url(conference_room, format: :json)