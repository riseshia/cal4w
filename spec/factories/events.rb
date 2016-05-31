# frozen_string_literal: true
FactoryGirl.define do
  factory :event, class: Event do
    subject "Subject"
    place "Place"
    description "MyText"
    association :user, strategy: :build
    start_time Time.zone.now
    finish_time Time.zone.now + 1.hour

    factory :event_2days_ago do
      start_time Time.zone.now - 2.days
      finish_time Time.zone.now - 2.days + 1.hour
    end

    factory :event_tomorrow do
      start_time Time.zone.now + 1.day
      finish_time Time.zone.now + 1.day + 1.hour
    end
  end
end
