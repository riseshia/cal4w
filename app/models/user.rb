# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :events_users
  has_many :events, through: :events_users

  validates :provider, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.from_slack(name)
    find_or_create_by(provider: "slack", nickname: name) do |user|
      user.token = Devise.friendly_token[0, 20]
      user.token_valid_until = Time.zone.now + 10.minutes
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def email_required?
    false
  end
end

# User::NoPermission
class User::NoPermission < StandardError; end
