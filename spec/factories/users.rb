# frozen_string_literal: true
FactoryGirl.define do
  factory :user, class: User do
    email "test@email.com"
    password "teafdafsdfa"
    provider "weirdx"
    nickname "name"
  end

  factory :user2, class: User do
    email "test2@email.com"
    password "teafdafsdfa"
    provider "weirdx"
    nickname "name2"
  end
end
