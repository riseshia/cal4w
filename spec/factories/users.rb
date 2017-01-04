# frozen_string_literal: true
FactoryGirl.define do
  factory :user, class: User do
    sequence(:id)
    provider "slack_signin"
    sequence(:email) { |n| "test#{n}@email.com" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:nickname) { |n| "name#{n}" }
  end
end
