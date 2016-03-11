# EventsHelper
module EventsHelper
  def classify_per_day(events)
    hash = {}
    events.select(&:ing_or_after?).each do |e|
      key = "#{e.start_time.month}-#{e.start_time.day}"
      if hash.key? key
        hash[key] << e
      else
        hash[key] = [e]
      end
    end
    hash
  end
end
