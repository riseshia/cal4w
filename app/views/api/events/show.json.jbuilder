json.extract! @event, :id, :subject, :place, :description, :start_time, :timezone, :finish_time
json.owner @event.user.mention_name
json.joiner_names @event.joiner_names
