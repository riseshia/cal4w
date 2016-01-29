json.array!(@events) do |event|
  json.extract! event, :id, :subject, :place, :description, :user_id
  json.url event_url(event, format: :html)
  json.id event.id
  json.title event.subject
  json.start event.start_time.iso8601
  json.end event.finish_time.iso8601
end
