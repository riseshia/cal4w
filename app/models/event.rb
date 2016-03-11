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

  def shift_day_with(datetime)
    self.start_time += ((datetime - self.start_time)/86400).day
    self.finish_time += ((datetime - self.finish_time)/86400).day
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

  PALATTE = [
    '#F49AC2', '#CB99C9', '#C23B22',
    '#FFD1DC', '#DEA5A4', '#AEC6CF',
    '#77DD77', '#CFCFC4', '#B39EB5',
    '#FFB347', '#B19CD9', '#FF6961',
    '#03C03C', '#FDFD96', '#836953',
    '#779ECB', '#966FD6'
  ]

  def to_hex
    PALATTE[user.id % PALATTE.size]
  end
end
