# frozen_string_literal: true
require "rails_helper"

RSpec.describe Event, type: :model do
  describe "Active Record Associations" do
    it { expect belong_to(:user) }
    it { expect have_many(:events_users) }
    it { expect have_many(:members).through(:events_users).source(:user) }
  end

  describe "Active Record Validations" do
    it { expect validate_presence_of(:user_id) }
    it { expect validate_presence_of(:subject) }
    it { expect validate_presence_of(:place) }
  end

  before(:example) do
    @event = create(:event)
    @user = @event.user
  end

  describe "#init_with_user" do
    it "will have user object" do
      user = build(:user)
      event = Event.init_with_user({}, user)
      expect(event.user).to eq(user)
    end
  end

  describe "#editable?" do
    it "expect return true" do
      expect(@event.editable?(@user)).to be(true)
    end

    it "expect return false" do
      user = create(:user)
      expect(@event.editable?(user)).to be(false)
    end
  end

  describe "#joined?" do
    it "expect return true when user is creator" do
      expect(@event.joined?(@user)).to be(true)
    end

    it "expect return true when user is joined" do
      user = create(:user)
      @event.members << user
      expect(@event.joined?(user)).to be(true)
    end

    it "expect return false when user is not joined" do
      user = create(:user)
      expect(@event.joined?(user)).to be(false)
    end
  end

  describe "#relative_time" do
    it "will include 오늘" do
      datetime = Time.zone.now.beginning_of_day + 1.hour
      formatted = datetime.strftime("%H:%M %:z")
      event = build(:event, start_time: datetime)
      expect(event.relative_time).to eq("오늘 #{formatted}")
    end

    it "will include 내일" do
      datetime = Time.zone.now.beginning_of_day + 1.day
      formatted = datetime.strftime("%H:%M %:z")
      event = build(:event, start_time: datetime)
      expect(event.relative_time).to eq("내일 #{formatted}")
    end

    it "will include only date" do
      datetime = Time.zone.now.beginning_of_day + 2.days
      event = build(:event, start_time: datetime)
      expect(event.relative_time).to eq(datetime.strftime("%F %H:%M %:z"))
    end
  end
end
