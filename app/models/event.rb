class Event < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :members, class_name: 'User', foreign_key: 'user_id'
end
