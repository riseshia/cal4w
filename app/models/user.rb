# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :events
  has_and_belongs_to_many :events, foreign_key: "user_id"

  validates :provider, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.from_slack(name, token)
    user = find_by(provider: "slack", nickname: name, token: token)
    return false if user.nil?
    return false if user.token != token
    return false if user.token_valid_until < Time.zone.now

    user.save
    user
  end

  def self.create_via_slack(name)
    user = find_or_create_by(provider: "slack", nickname: name)

    user.token = Devise.friendly_token[0, 20]
    user.token_valid_until = Time.zone.now + 10.minutes
    user.password = Devise.friendly_token[0, 20]
    user.save
    user
  end

  def email_required?
    false
  end
end

# User::NoPermission
class User::NoPermission < StandardError; end
