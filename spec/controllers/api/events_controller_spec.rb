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
        event = Event.create! valid_attributes
        get :index, format: :json
        expect(assigns(:events)).to eq([event])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        event = Event.create! valid_attributes
        get :show, id: event.to_param, format: :json
        expect(response).to have_http_status(:success)
      end
    end
  end
end
