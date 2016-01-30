class Event < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :members, class_name: 'User', foreign_key: 'user_id'

  validates :subject, presence: true
  validates :place, presence: true
  validates :user_id, presence: true

  def editable?(user)
    user.id == user_id ? true : false
  end
end
