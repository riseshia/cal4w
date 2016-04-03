# frozen_string_literal: true
# Event
class Event < ActiveRecord::Base
  include Colorable

  belongs_to :user
  has_and_belongs_to_many \
    :members,
    class_name: "User",
    association_foreign_key: "user_id"

  validates :subject, presence: true
  validates :place, presence: true
  validates :user_id, presence: true

  scope :with_user, -> { includes(:user) }

  def editable?(user)
    user.id == user_id
  end

  def joined?(user)
    return true if user.id == user_id
    members.exists?(user.id)
  end

  def ing_or_after?
    finish_time > Time.zone.now
  end

  def member_names
    members.map(&:nickname).unshift(user.nickname)
  end

  def shift_day_with(datetime)
    self.start_time += ((datetime - self.start_time) / 86_400).day
    self.finish_time += ((datetime - self.finish_time) / 86_400).day
  end

  def relative_time
    if start_time.today?
      "오늘 #{start_time.strftime('%H:%M')}시"
    elsif (start_time - 1.day).today?
      "내일 #{start_time.strftime('%H:%M')}시"
    else
      start_time.strftime("%F %H:%M")
    end
  end

  def to_slack_message
    "[#{subject}]\n주최자: #{user.nickname}\n시각: #{relative_time}\n장소: #{place}"
  end

  def notify_new_event(target_url)
    SlackWrapper.notify(
      '#_meetup',
      "새 밋업 일정이 추가되었습니다.\n#{to_slack_message}\n링크: #{target_url}"
    )
  end

  def notify_updated_event(target_url)
    SlackWrapper.notify(
      '#_meetup',
      "밋업 일정이 변경되었습니다.\n#{to_slack_message}\n링크: #{target_url}"
    )
  end

  def notify_destroyed_event
    SlackWrapper.notify(
      '#_meetup',
      "밋업 일정이 취소되었습니다.\n#{to_slack_message}"
    )
  end

  def notify_new_member(new_user, target_url)
    SlackWrapper.notify(
      user.nickname,
      "#{new_user.nickname}님이 '#{subject}' 밋업에 참가 신청하셨습니다.\n링크: #{target_url}"
    )
  end

  def notify_cancel_member(new_user, target_url)
    SlackWrapper.notify(
      user.nickname,
      "#{new_user.nickname}님이 '#{subject}' 밋업 참가를 취소하셨습니다.\n링크: #{target_url}"
    )
  end

  def to_hex_with
    user.id
  end
end
