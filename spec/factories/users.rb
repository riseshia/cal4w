FactoryGirl.define do
  factory :user do
    email 'test@email.com'
    password 'teafdafsdfa'
    provider 'slack'
    nickname 'name'
  end
end
