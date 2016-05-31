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
        get :index, format: :json
        expect(response).to have_http_status(:success)
      end

      it "return json object" do
        event = create(:event)
        get :index, format: :json
        expect(assigns(:events)).to eq([event])
      end

      it "returns events in range" do
        past_event = create(:event_2days_ago)
        future_event = create(:event_tomorrow)
        param = Time.zone.now.strftime("%F")

        get :index, format: :json, start: param
        expect(assigns(:events)).to eq([future_event])

        get :index, format: :json, end: param
        expect(assigns(:events)).to eq([past_event])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        event = create(:event)
        get :show, id: event.to_param, format: :json
        expect(response).to have_http_status(:success)
      end
    end
  end
end
