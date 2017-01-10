# frozen_string_literal: true
require "rails_helper"

RSpec.describe EventsController, type: :controller do
  let(:valid_attributes) do
    {
      "title" => "Subject",
      "place" => "Place",
      "description" => "MyText",
      "start_time(1i)" => "2020",
      "start_time(2i)" => "8",
      "start_time(3i)" => "19",
      "start_time(4i)" => "21",
      "start_time(5i)" => "00",
      "timezone" => "Seoul",
      "planned_time" => "5"
    }
  end

  let(:invalid_attributes) do
    {
      "title" => nil,
      "start_time(1i)" => "2016",
      "start_time(2i)" => "8",
      "start_time(3i)" => "19",
      "start_time(4i)" => "21",
      "start_time(5i)" => "00"
    }
  end

  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }

  before(:example) { sign_in user }

  describe "GET #index" do
    before { get :index }
    it { expect(response).to have_http_status(:success) }
  end

  describe "GET #show" do
    it "assigns the requested event as @event" do
      event = create(:event)
      get :show, params: { id: event.to_param }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe "POST #join" do
    it "creates a new Member" do
      event = create(:event)
      expect do
        post :join, params: { id: event.to_param }
      end.to change(event.members, :count).by(1)
    end
  end

  describe "POST #unjoin" do
    it "creates a new Member" do
      event = create(:event)
      event.members << user
      expect do
        post :unjoin, params: { id: event.to_param }
      end.to change(event.members, :count).by(-1)
    end
  end

  describe "GET #edit" do
    before { get :edit, params: { id: create(:event).to_param } }
    it { is_expected.to redirect_to(root_path) }
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Event" do
        expect do
          post :create, params: { event: valid_attributes }
        end.to change(Event, :count).by(1)
      end

      it "creates a valid event" do
        expected_start_time = Time.new(2020, 8, 19, 12, 0, 0, "+00:00")
        post :create, params: { event: valid_attributes }
        expect(assigns(:event).start_time).to \
          eq(expected_start_time)
      end

      it "assigns a newly created event as @event" do
        post :create, params: { event: valid_attributes }
        expect(assigns(:event)).to be_persisted
      end

      it "redirects to the created event" do
        post :create, params: { event: valid_attributes }
        expect(response).to redirect_to(Event.last)
      end
    end

    context "with invalid params" do
      before { post :create, params: { event: invalid_attributes } }
      it { is_expected.to render_template(:new) }
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          "start_time(1i)" => "2020",
          "start_time(2i)" => "8",
          "start_time(3i)" => "19",
          "start_time(4i)" => "21",
          "start_time(5i)" => "00"
        }
      end

      before(:example) do
        put :update, params: { id: event.to_param, event: event_params }
      end

      context "with valid params" do
        let(:event_params) { new_attributes }

        it "updates the requested event" do
          expect(assigns(:event)).to eq(event.reload)
        end

        it "creates a valid event" do
          expected_start_time = Time.new(2020, 8, 19, 12, 0, 0, "+00:00")
          expect(event.reload.start_time).to \
            eq(expected_start_time)
        end

        it "assigns the requested event as @event" do
          expect(assigns(:event)).to eq(event)
        end

        it { expect(response).to redirect_to(event) }
      end

      context "with invalid params" do
        let(:event_params) { invalid_attributes }
        it { is_expected.to render_template(:edit) }
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:event) { create(:event, user: user) }

    it "destroys the requested event" do
      expect do
        delete :destroy, params: { id: event.to_param }
      end.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      delete :destroy, params: { id: event.to_param }
      expect(response).to redirect_to(events_url)
    end
  end
end
