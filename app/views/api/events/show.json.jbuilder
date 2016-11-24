json.extract! @event, :id, :title, :place, :description, :start_time, :finish_time
json.owner @event.user.mention_name
json.joiner_names @event.joiner_names
