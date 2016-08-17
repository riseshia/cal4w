# frozen_string_literal: true
# EventForm
class EventForm
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :event
  attr_accessor :subject, :place, :description,
                :planned_time, :start_time, :timezone_offset

  validates :subject, presence: true
  validates :place, presence: true
  validates :start_time, presence: true
  validates :planned_time, presence: true, numericality: true
  validates :timezone_offset, presence: true

  def initialize(params = {}, event = nil)
    @subject = params[:subject]
    @place = params[:place]
    @description = params[:description]
    @timezone_offset = params[:timezone_offset].to_i
    @planned_time = params[:planned_time].to_i
    @start_time = extract_start_time(params)
    @event = event
  end

  def self.init_with_event(event)
    attrs = event.attributes.each_with_object({}) { |(k, v), obj| obj[k.to_sym] = v }
    new(attrs, event)
  end

  def persisted?
    event.present?
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

  SERVER_TZ_OFFSET = -540

  def extract_start_time(params)
    if params[:start_time].present?
      params[:start_time] + (SERVER_TZ_OFFSET - timezone_offset).minutes
    else
      struct_start_time(params)
    end
  end

  def struct_start_time(params)
    return if params["start_time(1i)"].nil?
    dt = (1..5).map { |i| params["start_time(#{i}i)"].to_i }
    Time.new(dt[0], dt[1], dt[2], dt[3], dt[4], 0, tz_from_offset)
  end

  def tz_from_offset
    sign = timezone_offset.positive? ? "-" : "+"
    hour = timezone_offset.abs / 60
    min = timezone_offset.abs % 60
    "#{sign}#{format('%02d', hour)}:#{format('%02d', min)}"
  end
end
