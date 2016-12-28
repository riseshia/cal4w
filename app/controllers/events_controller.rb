# frozen_string_literal: true
# EventsController
class EventsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create]
  before_action :permission_check, only: [:edit, :update, :destroy, :copy]

  def index
  end

  def show
    @user = current_user
  end

  def join
    @event.members << current_user
    @event.notify_new_member current_user, event_url(@event)
    redirect_to @event, notice: "Thanks to your join!"
  end

  def unjoin
    @event.members.destroy current_user
    @event.notify_cancel_member current_user, event_url(@event)
    redirect_to @event, notice: "Ok, I believe we could see soon! :)"
  end

  def new
    @event = Event.new(start_time: Time.zone.now + 1.hour)
    @event_form = EventForm.init_with_event(@event)
  end

  def edit
    Time.zone = @event.timezone
    @event_form = EventForm.init_with_event(@event)
  end

  def create
    @event_form = EventForm.init_with_params(event_form_params)
    @event = Event.init_with_user(@event_form.attributes, current_user)
    if @event_form.valid?
      @event.save!(validate: false)
      @event.notify_new_event event_url(@event)
      redirect_to @event, notice: "성공적으로 밋업을 만들었습니다."
    else
      @event.start_time = @event.start_time_in_tz
      render :new
    end
  end

  def update
    Time.zone = @event.timezone
    @event_form = EventForm.init_with_params(event_form_params)

    if @event_form.valid?
      @event.update_attributes(@event_form.attributes)
      @event.notify_updated_event event_url(@event)
      redirect_to @event, notice: "성공적으로 밋업을 변경했습니다."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    @event.notify_destroyed_event unless @event.persisted? # destroyed
    redirect_to events_url, notice: "밋업이 취소되었습니다."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_form_params
    params.require(:event).permit(
      :title, :place, :description,
      :start_time, :planned_time, :timezone
    )
  end

  def permission_check
    raise User::NoPermission unless @event.editable? current_user
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_path, notice: "해당하는 이벤트를 찾을 수 없습니다."
  end
end
