class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :events
  has_and_belongs_to_many :events

  validates :provider, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def nickname
    "@#{super}"
  end

  def email_required?
    false
  end
end

class User::NoPermission < StandardError; end
