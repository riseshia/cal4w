# frozen_string_literal: true
# EventForm
class EventForm
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :persisted
  attr_accessor :title, :place, :description,
                :planned_time, :start_time, :timezone

  validates :title, presence: true
  validates :place, presence: true
  validates :start_time, presence: true
  validates :planned_time, presence: true, numericality: true
  validates :timezone, presence: true
  validate :start_time_cannot_be_in_the_past

  def initialize(params = {})
    self.title = params[:title]
    self.place = params[:place]
    self.description = params[:description]
    self.start_time = params[:start_time]
    self.timezone = params[:timezone]
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
    { title: title,
      place: place,
      description: description,
      start_time: start_time,
      planned_time: planned_time,
      timezone: timezone }
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
    Time.zone = params[:timezone]
    Time.zone.local(*dt, 0)
  end
end
