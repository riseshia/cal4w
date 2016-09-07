# frozen_string_literal: true
# User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack_signin]

  has_many :event_users
  has_many :events, through: :event_users

  validates :provider, presence: true

  def self.from_omniauth(auth)
    raise User::DifferentGroup \
      if auth.info.team.id != Rails.application.secrets.slack_team_id

    # There is some bug. uid is upcased string.
    # but ActiveRecord use "upcase" when query, however,
    # inserted value is downcased. ;(
    uid = auth.info.user.id.downcase
    find_or_create_by(provider: auth.provider, uid: uid) do |user|
      user.nickname = SlackWrapper.user_name(uid)
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
