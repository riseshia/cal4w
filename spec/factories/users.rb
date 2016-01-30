FactoryGirl.define do
  factory :user, class: User do
    email 'test@email.com'
    password 'teafdafsdfa'
    provider 'slack'
    nickname 'name'
  end

  factory :user2, class: User do
    email 'test2@email.com'
    password 'teafdafsdfa'
    provider 'slack'
    nickname 'name2'
  end    
end
