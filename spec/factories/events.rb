# frozen_string_literal: true
FactoryGirl.define do
  factory :event, class: Event do
    subject "Subject"
    place "Place"
    description "MyText"
    association :user, strategy: :build
    start_time Time.zone.now
    planned_time 1

    factory :event_2days_ago do
      start_time Time.zone.now - 2.days
    end

    factory :event_tomorrow do
      start_time Time.zone.now + 1.day
    end
  end
end
