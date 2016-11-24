json.array!(@events) do |event|
  json.id event.id
  json.user_id event.user_id
  json.title event.title
  json.place event.place
  json.description event.description
  json.start event.start_time.iso8601
  json.end event.finish_time.iso8601
  json.color event.to_hex
  json.member_names event.member_names
  json.url event_url(event)
end
