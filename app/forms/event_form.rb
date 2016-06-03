# frozen_string_literal: true
# EventForm
class EventForm
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :event
  attr_accessor :subject, :place, :description,
                :start_time, :finish_time, :timezone

  before_validation :set_finish_time

  validates :subject, presence: true
  validates :place, presence: true
  validates :start_time, presence: true
  validates :planned_time, presence: true, numericality: true

  def initialize(params = {}, event = nil)
    @subject = params[:subject]
    @place = params[:place]
    @description = params[:description]
    @start_time = extract_start_time(params)
    @planned_time = params[:planned_time].to_i
    @timezone = params[:timezone]
    @event = event
  end

  def self.init_with_event(event)
    attrs = event.attributes.map { |k, v| [k.to_sym, v] }
    new(Hash[attrs], event)
  end

  def planned_time
    if finish_time.nil? && start_time.nil?
      1
    elsif finish_time.present? && start_time.present?
      ((finish_time - start_time) / 1.hour).to_i
    else
      @planned_time
    end
  end

  def persisted?
    event.present?
  end

  def attributes
    { subject: subject,
      place: place,
      description: description,
      start_time: start_time,
      finish_time: finish_time }
  end

  private

  def extract_start_time(params)
    if params["start_time"].present?
      Time.zone.parse(params["start_time"])
    else
      struct_start_time(params)
    end
  end

  def struct_start_time(params)
    return if params["start_time(1i)"].nil?
    attrs = (1..5).map do |i|
      params["start_time(#{i}i)"].to_i
    end
    Time.zone.local(attrs[0], attrs[1], attrs[2], attrs[3], attrs[4], 0)
  end

  def set_finish_time
    if start_time.present? && planned_time.present?
      self.finish_time = start_time + planned_time.hour
    end
  end
end
