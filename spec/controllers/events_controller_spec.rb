# frozen_string_literal: true
require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe EventsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Event. As you add validations to Event, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      subject: "Subject",
      place: "Place",
      description: "MyText",
      start_time: Time.zone.now,
      finish_time: Time.zone.now + 1.hour
    }
  end

  let(:invalid_attributes) do
    { subject: nil }
  end

  before(:example) do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET #index' do
    it "assigns all events as @events" do
      event = create(:event)
      get :index, {}
      expect(assigns(:events)).to eq([event])
    end
  end

  describe 'GET #show' do
    it "assigns the requested event as @event" do
      event = create(:event)
      get :show, id: event.to_param
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST #join' do
    it "creates a new Member" do
      event = create(:event)
      expect do
        post :join, id: event.to_param
      end.to change(event.members, :count).by(1)
    end
  end

  describe 'POST #unjoin' do
    it "creates a new Member" do
      event = create(:event)
      event.members << @user
      expect do
        post :unjoin, id: event.to_param
      end.to change(event.members, :count).by(-1)
    end
  end

  describe 'GET #new' do
    it "assigns a new event as @event" do
      get :new, {}
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET #edit' do
    it "assigns the requested event as @event" do
      event = create(:event, user: @user)
      get :edit, id: event.to_param
      expect(assigns(:event)).to eq(event)
    end

    it "will be redirected root_path if try to edit the others event" do
      event = create(:event)
      get :edit, id: event.to_param
      expect(response).to redirect_to("/")
    end
  end

  describe 'POST #create' do
    context "with valid params" do
      it "creates a new Event" do
        expect do
          post :create, event: valid_attributes
        end.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, event: valid_attributes
        expect(assigns(:event)).to be_a(Event)
        expect(assigns(:event)).to be_persisted
      end

      it "redirects to the created event" do
        post :create, event: valid_attributes
        expect(response).to redirect_to(Event.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        post :create, event: invalid_attributes
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, event: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end

  describe 'PUT #update' do
    context "with valid params" do
      let(:new_attributes) do
        { subject: "New Subject" }
      end

      it "updates the requested event" do
        event = create(:event, user: @user)
        put :update, id: event.to_param, event: new_attributes
        event.reload
        expect(assigns(:event)).to eq(event)
      end

      it "assigns the requested event as @event" do
        event = create(:event, user: @user)
        put :update, id: event.to_param, event: valid_attributes
        expect(assigns(:event)).to eq(event)
      end

      it "redirects to the event" do
        event = create(:event, user: @user)
        put :update, id: event.to_param, event: valid_attributes
        expect(response).to redirect_to(event)
      end
    end

    context "with invalid params" do
      it "assigns the event as @event" do
        event = create(:event, user: @user)
        put :update, id: event.to_param, event: invalid_attributes
        expect(assigns(:event)).to eq(event)
      end

      it "re-renders the 'edit' template" do
        event = create(:event, user: @user)
        put :update, id: event.to_param, event: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe 'DELETE #destroy' do
    it "destroys the requested event" do
      event = create(:event, user: @user)
      expect do
        delete :destroy, id: event.to_param
      end.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = create(:event, user: @user)
      delete :destroy, id: event.to_param
      expect(response).to redirect_to(events_url)
    end
  end
end
