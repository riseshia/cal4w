# frozen_string_literal: true
module Api
  # Api::EventsController
  class EventsController < Api::BaseController
    respond_to :json

    def index
      @events = Event.with_users.order(start_time: :asc)
    end

    def show
      @event = Event.find(params[:id])
      @user = current_user
    end
  end
end
