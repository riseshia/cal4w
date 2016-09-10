# frozen_string_literal: true
FactoryGirl.define do
  factory :event, class: Event do
    subject "Subject"
    place "Place"
    description "MyText"
    association :user, strategy: :build
    start_time 1.day.from_now
    timezone_offset(-540)
    planned_time 1
  end
end
