# frozen_string_literal: true
# EventsController
class EventsController < ApplicationController
  before_action :permission_check, only: [:edit, :update, :destroy, :copy]

  def index; end

  def show
    event
    @user = current_user
  end

  def join
    message = \
      if event.joined? current_user
        "You already joined! :)"
      else
        event.members << current_user
        event.notify_new_member current_user, event_url(event)
        "Thanks to your join!"
      end
    redirect_to event, notice: message
  end

  def unjoin
    event.members.destroy current_user
    event.notify_cancel_member current_user, event_url(event)
    redirect_to event, notice: "Ok, I believe we could see soon! :)"
  end

  def new
    Time.zone = "Seoul"
    @event = Event.new(start_time: Time.zone.now + 1.hour)
  end

  def edit
    Time.zone = event.timezone
  end

  def create
    Time.zone = event_params[:timezone] || "Seoul"
    @event = Event.init_with_user(event_params, current_user)
    if @event.save
      @event.notify_new_event event_url(@event)
      redirect_to @event, notice: "성공적으로 밋업을 만들었습니다."
    else
      render :new
    end
  end

  def update
    Time.zone = event.timezone

    if event.update(event_params)
      event.notify_updated_event event_url(event)
      redirect_to event, notice: "성공적으로 밋업을 변경했습니다."
    else
      render :edit
    end
  end

  def destroy
    event.notify_destroyed_event unless event.destroy
    redirect_to events_url, notice: "밋업이 취소되었습니다."
  end

  private

  def event_params
    params.require(:event).permit(
      :title, :place, :description,
      :start_time, :planned_time, :timezone
    )
  end

  def event
    @event ||= Event.find(params[:id])
  end

  def permission_check
    raise User::NoPermission unless event.organizer? current_user
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_path, notice: "해당하는 이벤트를 찾을 수 없습니다."
  end
end
