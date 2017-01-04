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
      "timezone_offset" => "-600",
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

  before(:example) do
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "return http status 200" do
      get :index
      expect(response).to have_http_status(:success)
    end
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
      event.members << @user
      expect do
        post :unjoin, params: { id: event.to_param }
      end.to change(event.members, :count).by(-1)
    end
  end

  describe "GET #edit" do
    it "will be redirected root_path if try to edit the others event" do
      event = create(:event)
      get :edit, params: { id: event.to_param }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Event" do
        expect do
          post :create, params: { event: valid_attributes }
        end.to change(Event, :count).by(1)
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
      it "re-renders the 'new' template" do
        post :create, params: { event: invalid_attributes }
        expect(response).to render_template("new")
      end
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

      it "updates the requested event" do
        event = create(:event, user: @user)
        updated_attributes = event.attributes.merge(new_attributes)
        put :update, params: { id: event.to_param, event: updated_attributes }
        event.reload
        expect(assigns(:event)).to eq(event)
      end

      it "assigns the requested event as @event" do
        event = create(:event, user: @user)
        updated_attributes = event.attributes.merge(new_attributes)
        put :update,
            params: { id: event.to_param, event: updated_attributes }
        expect(assigns(:event)).to eq(event)
      end

      it "redirects to the event" do
        event = create(:event, user: @user)
        updated_attributes = event.attributes.merge(new_attributes)
        put :update,
            params: { id: event.to_param, event: updated_attributes }
        expect(response).to redirect_to(event)
      end
    end

    context "with invalid params" do
      it "re-renders the 'edit' template" do
        event = create(:event, user: @user)
        updated_attributes = event.attributes.merge(invalid_attributes)
        put :update,
            params: { id: event.to_param, event: updated_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested event" do
      event = create(:event, user: @user)
      expect do
        delete :destroy, params: { id: event.to_param }
      end.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = create(:event, user: @user)
      delete :destroy, params: { id: event.to_param }
      expect(response).to redirect_to(events_url)
    end
  end
end
