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
    let(:provider) { "weirdx" }
    let(:uid) { "1245324" }
    let(:username) { "luna" }

    let(:fetch_user) { User.from_omniauth(provider, uid, username) }

    context "creates one user" do
      it { expect { fetch_user }.to change { User.count }.by(1) }
    end

    context "get exist user" do
      before { create(:user, provider: provider, uid: uid) }
      it { expect { fetch_user }.not_to change { User.count } }
    end
  end
end
