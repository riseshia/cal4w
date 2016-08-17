# frozen_string_literal: true
# Event
class Event < ApplicationRecord
  include Colorable

  belongs_to :user
  has_many :events_users
  has_many :members, through: :events_users, source: :user

  validates :subject, presence: true
  validates :place, presence: true
  validates :start_time, presence: true
  validates :planned_time, presence: true
  validates :user_id, presence: true

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

  def ing_or_after?
    finish_time > Time.zone.now
  end

  def member_names
    members.map(&:mention_name).unshift(user.mention_name)
  end

  def shift_day_with(datetime)
    self.start_time += ((datetime - self.start_time) / 86_400).day
  end

  SERVER_TZ_OFFSET = -540
  def start_time_with_tz
    @start_time_with_tz ||=
      start_time + (SERVER_TZ_OFFSET - timezone_offset).minutes
  end

  def relative_time
    if start_time_with_tz.today?
      "오늘 #{start_time_with_tz.strftime('%H:%M')} #{tz_from_offset}"
    elsif (start_time_with_tz - 1.day).today?
      "내일 #{start_time_with_tz.strftime('%H:%M')} #{tz_from_offset}"
    else
      start_time_with_tz.strftime("%F %H:%M") + " #{tz_from_offset}"
    end
  end

  def to_slack_message
    "[#{subject}]\n주최자: #{user.nickname}\n시각: #{relative_time}\n장소: #{place}"
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
      "#{new_user.nickname}님이 '#{subject}' 밋업에 참가 신청하셨습니다.\n링크: #{target_url}"
    )
  end

  def notify_cancel_member(new_user, target_url)
    SlackWrapper.notify(
      user.mention_name,
      "#{new_user.nickname}님이 '#{subject}' 밋업 참가를 취소하셨습니다.\n링크: #{target_url}"
    )
  end

  def to_hex_with
    user&.id || 0
  end

  def tz_from_offset
    sign = timezone_offset.positive? ? "-" : "+"
    hour = timezone_offset.abs / 60
    min = timezone_offset.abs % 60
    "#{sign}#{format('%02d', hour)}:#{format('%02d', min)}"
  end
end
