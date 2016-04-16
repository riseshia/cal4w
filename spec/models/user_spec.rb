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

  describe "#from_slack" do
    it "will create new user" do
      User.from_slack("name")
      expect change(User, :count).by(1)
    end

    it "will return exist user" do
      user = create(:user)
      expect(User.from_slack(user.nickname)).to eq(user)
    end
  end

  describe "#generate_token" do
    it "will have no token when it created" do
      user = create(:user)
      expect(user.token).to be_nil
    end

    it "will regenerate token" do
      user = create(:user)
      user.generate_token
      expect(user.token).not_to be_nil
    end
  end
end
