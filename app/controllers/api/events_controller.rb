# frozen_string_literal: true
module Api
  # Api::EventsController
  class EventsController < Api::BaseController
    def index
      @events = Event
                .with_users
                .since_date(params[:start])
                .until_date(params[:end])
                .order(start_time: :asc)
    end

    def show
      @event = Event.find(params[:id])
      @user = current_user
    end
  end
end
