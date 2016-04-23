json.array!(@events) do |event|
  json.extract! event, :id, :subject, :place, :description, :user_id
  json.url event_url(event)
  json.id event.id
  json.title event.subject
  json.start event.start_time.iso8601
  json.end event.finish_time.iso8601
  json.color event.to_hex
  json.member_names event.member_names
end
