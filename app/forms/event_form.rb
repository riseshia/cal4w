# frozen_string_literal: true
# EventForm
class EventForm
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :persisted
  attr_accessor :subject, :place, :description,
                :planned_time, :start_time, :timezone_offset

  validates :subject, presence: true
  validates :place, presence: true
  validates :start_time, presence: true
  validates :planned_time, presence: true, numericality: true
  validates :timezone_offset, presence: true
  validate :start_time_cannot_be_in_the_past

  def initialize(params = {})
    self.subject = params[:subject]
    self.place = params[:place]
    self.description = params[:description]
    self.start_time = params[:start_time]
    self.timezone_offset = params[:timezone_offset].to_i
    self.planned_time = params[:planned_time]&.to_i || 1
  end

  def self.init_with_params(params = {})
    instance = new(params)
    instance.start_time = DateTimeUtil.extract_time(params, "start_time")
    instance
  end

  def self.init_with_event(event)
    attrs = event
            .attributes
            .each_with_object({}) { |(k, v), obj| obj[k.to_sym] = v }
    new(attrs)
  end

  def attributes
    { subject: subject,
      place: place,
      description: description,
      start_time: start_time,
      planned_time: planned_time,
      timezone_offset: timezone_offset }
  end

  private

  def start_time_cannot_be_in_the_past
    if start_time && start_time < Time.zone.now
      errors.add(:start_time, "is past datetime.")
    end
  end
end

# DateTimeUtil
module DateTimeUtil
  module_function

  def extract_time(params, attr_name)
    dt = (1..5).map { |i| params["#{attr_name}(#{i}i)"].to_i }
    Time.new(*dt, 0, "+00:00").utc
  end
end
