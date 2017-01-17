# frozen_string_literal: true
# User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack_signin, :weirdx]

  has_many :event_users
  has_many :events, through: :event_users

  validates :provider, presence: true

  def self.from_omniauth(provider, uid, username)
    find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = username
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # For DEVISE
  def email_required?
    false
  end

  def mention_name
    "@" + nickname
  end

  NoPermission = Class.new(StandardError)
  NotFound = Class.new(StandardError)
  DifferentGroup = Class.new(StandardError)
end
