# frozen_string_literal: true
FactoryGirl.define do
  factory :event, class: Event do
    subject "Subject"
    place "Place"
    description "MyText"
    user_id 1
    start_time Time.zone.now
    finish_time Time.zone.now + 1.hour
  end

  factory :event2, class: Event do
    subject "Subject"
    place "Place"
    description "MyText"
    user_id 2
    start_time Time.zone.now
    finish_time Time.zone.now + 1.hour
  end
end
