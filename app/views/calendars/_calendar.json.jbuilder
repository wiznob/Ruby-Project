json.extract! calendar, :id, :title, :description, :start_time, :end_time, :created_at, :updated_at
json.url calendar_url(calendar, format: :json)
