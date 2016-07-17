# frozen_string_literal: true
# User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack_signin]

  has_many :events_users
  has_many :events, through: :events_users

  validates :provider, presence: true

  def self.from_omniauth(auth)
    raise User::DifferentGroup if auth.info.team.id != ENV["WEIRDX_TEAM_ID"]
    where(provider: auth.provider, uid: auth.info.user.id)
      .first_or_create do |user|
      user.nickname = SlackWrapper.user_name(auth.info.user.id)
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def email_required?
    false
  end

  def mention_name
    "@" + nickname
  end
end

# User::NoPermission
class User
  class NoPermission < StandardError
  end

  class NotFound < StandardError
  end

  class DifferentGroup < StandardError
  end
end
