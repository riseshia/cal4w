# frozen_string_literal: true
require "rails_helper"

module Api
  RSpec.describe EventsController, type: :controller do
    let(:valid_attributes) do
      attributes_for(:event)
    end

    before(:example) do
      @user = create(:user)
      sign_in @user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index, params: { format: :json }
        expect(response).to have_http_status(:success)
      end

      it "return json object" do
        event = create(:event)
        get :index, params: { format: :json }
        expect(assigns(:events)).to eq([event])
      end

      let(:event_2days_ago) do
        event = Event.new(title: "Subject", place: "Place",
                          description: "Description", user: create(:user),
                          start_time: 2.days.ago, planned_time: 1)
        event.save(validate: false)
        event
      end

      it "returns events in range" do
        past_event = event_2days_ago
        future_event = create(:event, start_time: 1.day.from_now)
        param = Time.zone.now.strftime("%F")

        get :index, params: { format: :json, start: param }
        expect(assigns(:events)).to eq([future_event])

        get :index, params: { format: :json, end: param }
        expect(assigns(:events)).to eq([past_event])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        event = create(:event)
        get :show, params: { id: event.to_param, format: :json }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
