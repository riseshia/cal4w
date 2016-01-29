FactoryGirl.define do
  factory :event do
    subject "Subject"
    place "Place"
    description "MyText"
    user_id 1
    start_time Time.zone.now
    finish_time Time.zone.now + 1.hour
  end
end
