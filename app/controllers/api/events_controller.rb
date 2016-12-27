# frozen_string_literal: true
module Api
  # Api::EventsController
  class EventsController < Api::BaseController
    def index
      @events = Event.between_period_with_users(params[:start], params[:end])
    end

    def show
      @event = Event.find(params[:id])
      @user = current_user
    end
  end
end
