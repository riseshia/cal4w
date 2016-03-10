module EventsHelper
  def classify_per_day events
    hash = {}
    events.select { |e| e.ing_or_after? }.each { |e|
      key = "#{e.start_time.month}-#{e.start_time.day}"
      if hash.key? key
        hash[key] << e
      else
        hash[key] = [e]
      end
    }
    hash
  end
end
