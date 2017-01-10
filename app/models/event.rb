# frozen_string_literal: true
# Event
class Event < ApplicationRecord
  include Colorable

  belongs_to :user
  has_many :event_users, dependent: :destroy
  has_many :members, through: :event_users, source: :user

  validates :title, presence: true
  validates :place, presence: true
  validates :start_time, presence: true
  validates :planned_time, presence: true, numericality: true
  validates :timezone, presence: true

  # public scope
  scope :between_period_with_users, lambda { |start_date, end_date|
    with_users
      .since_date(start_date)
      .until_date(end_date)
      .order(start_time: :asc)
  }

  # private scope
  scope :with_users, -> { includes(:user, :members) }
  scope :since_date, lambda { |date|
    where("start_time > ?", Time.zone.parse(date)) if date
  }
  scope :until_date, lambda { |date|
    where("start_time < ?", Time.zone.parse(date)) if date
  }

  def self.init_with_user(attrs, user)
    event = new(attrs)
    event.user = user
    event
  end

  def editable?(user)
    user.id == user_id
  end

  def joined?(user)
    return true if user.id == user_id
    members.exists?(user.id)
  end

  def finish_time
    start_time + planned_time.hours
  end

  def in_time?
    finish_time > Time.zone.now
  end

  def joiner_names
    members.map(&:mention_name)
  end

  def member_names
    joiner_names.unshift(user.mention_name)
  end

  def human_readable_time
    start_time
  end

  def notify_new_event(target_url)
    SlackWrapper.notify(
      "#_meetup",
      "새 밋업 일정이 추가되었습니다.\n#{to_slack_message}\n링크: #{target_url}"
    )
  end

  def notify_updated_event(target_url)
    SlackWrapper.notify(
      "#_meetup",
      "밋업 일정이 변경되었습니다.\n#{to_slack_message}\n링크: #{target_url}"
    )
  end

  def notify_destroyed_event
    SlackWrapper.notify(
      "#_meetup",
      "밋업 일정이 취소되었습니다.\n#{to_slack_message}"
    )
  end

  def notify_new_member(new_user, target_url)
    SlackWrapper.notify(
      user.mention_name,
      "#{new_user.nickname}님이 '#{title}' 밋업에 참가 신청하셨습니다.\n링크: #{target_url}"
    )
  end

  def notify_cancel_member(new_user, target_url)
    SlackWrapper.notify(
      user.mention_name,
      "#{new_user.nickname}님이 '#{title}' 밋업 참가를 취소하셨습니다.\n링크: #{target_url}"
    )
  end

  private

  def to_slack_message
    "[#{title}]\n" \
    "주최자: #{user.nickname}\n" \
    "시각: #{human_readable_time}\n" \
    "장소: #{place}"
  end

  def to_hex_with
    user&.id || 0
  end
end
