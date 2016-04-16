# frozen_string_literal: true
FactoryGirl.define do
  factory :event, class: Event do
    subject "Subject"
    place "Place"
    description "MyText"
    association :user, strategy: :build
    start_time Time.zone.now
    finish_time Time.zone.now + 1.hour
  end
end
