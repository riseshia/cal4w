# frozen_string_literal: true
# EventsHelper
module EventsHelper
  TIMEZONE_OPTIONS =
    [["(GMT-11:00)", 660], ["(GMT-10:00)", 600], ["(GMT-09:00)", 540],
     ["(GMT-08:00) PST", 480], ["(GMT-07:00)", 420], ["(GMT-06:00) CST", 360],
     ["(GMT-05:00) EST", 300], ["(GMT-04:00)", 240], ["(GMT-03:30)", 210],
     ["(GMT-03:00)", 180], ["(GMT-02:00)", 120], ["(GMT-01:00)", 60],
     ["(GMT+00:00)", 0], ["(GMT+01:00)", -60], ["(GMT+02:00)", -120],
     ["(GMT+03:00)", -180], ["(GMT+03:30)", -210], ["(GMT+04:00)", -240],
     ["(GMT+04:30)", -270], ["(GMT+05:00)", -300], ["(GMT+05:30)", -330],
     ["(GMT+05:45)", -345], ["(GMT+06:00)", -360], ["(GMT+06:30)", -390],
     ["(GMT+07:00)", -420], ["(GMT+08:00)", -480],
     ["(GMT+09:00) 한국, 일본", -540],
     ["(GMT+09:30)", -570],
     ["(GMT+10:00) 호주 동부", -600], ["(GMT+11:00) 호주 서부", -660],
     ["(GMT+12:00)", -720], ["(GMT+12:45)", -765], ["(GMT+13:00)", -780]].freeze

  def timezone_options
    TIMEZONE_OPTIONS
  end

  def event_submit_path(event_form)
    if event_form.persisted?
      event_path(event_form.event)
    else
      events_path
    end
  end
end
