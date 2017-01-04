# frozen_string_literal: true
require "rails_helper"

module Users
  RSpec.describe DummySessionsController, type: :controller do
    before(:example) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    describe "#new" do
      before { get :new }
      subject { response }
      it { is_expected.to have_http_status(:success) }
    end

    describe "#create" do
      context "has user already" do
        let!(:user) { create(:user) }

        it "gets exist user" do
          expect do
            post :create, params: { nickname: user.nickname }
          end.to change(User, :count).by(0)
        end
      end

      context "new user" do
        it "creates new user" do
          expect do
            post :create, params: { nickname: "new_user" }
          end.to change(User, :count).by(1)
        end
      end

      context "success to sign in" do
        before { post :create, params: { nickname: "user" } }
        it { is_expected.to redirect_to(root_path) }
      end
    end

    describe "#destroy" do
      before do
        sign_in create(:user)
        delete :destroy
      end

      it { is_expected.to redirect_to(root_path) }
    end
  end
end
