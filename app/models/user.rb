# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack]

  has_many :events_users
  has_many :events, through: :events_users

  validates :provider, presence: true

  def self.from_omniauth(auth)
    return nil if auth.info.team.id != ENV["WEIRDX_TEAM_ID"]
    where(provider: auth.provider, uid: auth.info.nickname.id).
    first_or_create do |user|
      user.nickname = auth.info.nickname.name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def email_required?
    false
  end
end

# User::NoPermission
class User
  class NoPermission < StandardError
  end
end
