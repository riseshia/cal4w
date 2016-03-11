class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :join, :unjoin, :update, :destroy]
  before_action :permission_check, only: [:edit, :update, :destroy]

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
    notify_new_member @event, current_user
    redirect_to @event, notice: 'Thanks to your join!'
  end

  def unjoin
    @event.members.destroy current_user
    notify_cancel_member @event, current_user
    redirect_to @event, notice: 'Ok, I believe we could see soon! :)'
  end

  def new
    @event = Event.new(start_time: Time.zone.now, finish_time: Time.zone.now + 1.hour)
    @event.apply_timezone
    respond_with(@event)
  end

  def edit
    @event.apply_timezone
  end

  def create
    @event = Event.new(event_params)
    @event.restore_timezone
    @event.user = current_user
    notify_new_event @event if @event.save

    respond_with(@event)
  end

  def update
    @event.update(event_params)
    @event.restore_timezone
    notify_updated_event @event if @event.save

    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private

  def notify_new_event event
    notify_to_slack '#_meetup', "새 밋업 일정이 추가되었습니다.\n#{event.to_slack_message}\n링크: #{event_url(event)}"
  end

  def notify_updated_event event
    notify_to_slack '#_meetup', "밋업 일정이 변경되었습니다.\n#{event.to_slack_message}\n링크: #{event_url(event)}"
  end

  def notify_new_member event, user
    notify_to_slack event.user.nickname, "#{user.nickname}님이 '#{event.subject}' 밋업에 참가 신청하셨습니다.\n링크: #{event_url(event)}"
  end

  def notify_cancel_member event, user
    notify_to_slack event.user.nickname, "#{user.nickname}님이 '#{event.subject}' 밋업 참가를 취소하셨습니다.\n링크: #{event_url(event)}"
  end

  def notify_to_slack(channel, text)
    return unless Rails.env.production?
    Slack::Web::Client.new.chat_postMessage(
      channel: channel,
      text: text,
      as_user: true,
      username: 'Cal4Weirdx'
    )
  end

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
