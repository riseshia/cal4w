# frozen_string_literal: true
require "rails_helper"

RSpec.describe User, type: :model do
  describe "Active Record Associations" do
    it { expect have_many(:events_users) }
    it { expect have_many(:events).through(:events_users) }
  end

  describe "Active Record Validations" do
    it { expect validate_presence_of(:provider) }
  end

  describe ".from_omniauth" do
    before(:each) do
      allow(SlackWrapper).to receive(:user_name) { "user_name" }
    end

    let(:auth) do
      team = OpenStruct.new(id: team_id)
      user = OpenStruct.new(id: "USER_ID")
      info = OpenStruct.new(team: team, user: user)
      OpenStruct.new(info: info, provider: "slack_signin")
    end

    context "with wrong provider" do
      let(:team_id) { "wrong_team_id" }
      it "will raise User::DifferentGroup error" do
        expect { User.from_omniauth(auth) }.to \
          raise_error(User::DifferentGroup)
      end
    end

    context "with correct provider" do
      let(:team_id) { "team_id" }
      it "creates one user" do
        expect { User.from_omniauth(auth) }.to \
          change { User.count }.by(1)
      end

      it "get exist user" do
        User.from_omniauth(auth)
        expect { User.from_omniauth(auth) }.not_to \
          change { User.count }
      end
    end
  end
end
