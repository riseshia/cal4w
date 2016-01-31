module EventsHelper
  def time_format(time)
    time.in_time_zone('Seoul').strftime('%F %H:%M')
  end
end
