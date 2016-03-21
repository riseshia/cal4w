# frozen_string_literal: true
require "rails_helper"

RSpec.describe Event, type: :model do
  describe "Active Record Validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:place) }
  end

  before(:example) do
    @user = create(:user)
    @event = create(:event)
  end

  describe '#editable?' do
    it "should return true" do
      expect(@event.editable?(@user)).to be(true)
    end

    it "should return false" do
      user = create(:user2)
      expect(@event.editable?(user)).to be(false)
    end
  end

  describe '#joined?' do
    it "should return true when user is creator" do
      expect(@event.joined?(@user)).to be(true)
    end

    it "should return true when user is joined" do
      user = create(:user2)
      @event.members << user
      expect(@event.joined?(user)).to be(true)
    end

    it "should return false when user is not joined" do
      user = create(:user2)
      expect(@event.joined?(user)).to be(false)
    end
  end
end
