class Event < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :members, class_name: 'User', association_foreign_key: 'user_id'

  validates :subject, presence: true
  validates :place, presence: true
  validates :user_id, presence: true

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

  def apply_timezone
    self.start_time += 9.hours
    self.finish_time += 9.hours
  end

  def restore_timezone
    self.start_time -= 9.hours
    self.finish_time -= 9.hours
  end

  def start_time_with_tz
    start_time.in_time_zone('Seoul')
  end

  def finish_time_with_tz
    finish_time.in_time_zone('Seoul')
  end

  def relative_time
    if start_time_with_tz.today?
      "오늘 #{start_time_with_tz.strftime('%H:%M')}시"
    elsif (start_time_with_tz - 1.day).today?
      "내일 #{start_time_with_tz.strftime('%H:%M')}시"
    else
      start_time_with_tz.strftime('%F %H:%M')
    end
  end

  def to_slack_message
    "[#{subject}]\n주최자: #{user.nickname}\n시각: #{relative_time}\n장소: #{place}"
  end
end
