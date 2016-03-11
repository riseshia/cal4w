class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :join, :unjoin, :update, :destroy, :copy]
  before_action :permission_check, only: [:edit, :update, :destroy, :copy]

  respond_to :html, :json

  def index
    @events = Event.all
    respond_with(@events)
  end

  def show
    @user = current_user
    respond_with(@event)
  end

  def join
    @event.members << current_user
    @event.notify_new_member current_user, event_url(@event)
    redirect_to @event, notice: 'Thanks to your join!'
  end

  def unjoin
    @event.members.destroy current_user
    @event.notify_cancel_member current_user, event_url(@event)
    redirect_to @event, notice: 'Ok, I believe we could see soon! :)'
  end

  def new
    @event = Event.new(start_time: Time.zone.now, finish_time: Time.zone.now + 1.hour)
    respond_with(@event)
  end

  def copy
    @new_event = @event.dup
    @new_event.shift_day_with(Time.zone.now)
    @event = @new_event
    render :new
  end

  def edit
    @event.apply_timezone
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.notify_new_event event_url(@event) if @event.save
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    @event.notify_updated_event event_url(@event) if @event.save
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:subject, :place, :description, :start_time, :finish_time)
  end

  def permission_check
    raise User::NoPermission unless @event.editable? current_user
  end
end
