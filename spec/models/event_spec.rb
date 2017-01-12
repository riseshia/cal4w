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
    it { expect validate_presence_of(:title) }
    it { expect validate_presence_of(:place) }
    it { expect validate_presence_of(:start_time) }
    it { expect validate_presence_of(:planned_time) }
  end

  before(:example) do
    @event = create(:event)
    @user = @event.user
  end

  describe "Active Record Scope" do
    describe "#between_period_with_users" do
      subject { Event.between_period_with_users(start_date, end_date).count }

      let(:start_date) { 7.days.ago.strftime("%Y-%m-%d") }
      let(:end_date) { Time.zone.now.strftime("%Y-%m-%d") }

      context "previous event not in period" do
        before { create(:event, start_time: 10.days.ago) }
        it { is_expected.to eq(0) }
      end

      context "one event in period" do
        before { create(:event, start_time: 2.days.ago) }
        it { is_expected.to eq(1) }
      end

      context "future event not in period" do
        before { create(:event, start_time: 2.days.from_now) }
        it { is_expected.to eq(0) }
      end
    end
  end

  describe "#init_with_user" do
    it "will have user object" do
      user = build(:user)
      event = Event.init_with_user({}, user)
      expect(event.user).to eq(user)
    end
  end

  describe "#organizer?" do
    it "expect return true" do
      expect(@event.organizer?(@user)).to be(true)
    end

    it "expect return false" do
      user = create(:user)
      expect(@event.organizer?(user)).to be(false)
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

  describe "#in_time?" do
    subject { event.in_time? }
    let(:event) do
      build(:event, start_time: 2.hours.ago, planned_time: planned_time)
    end

    context "in time" do
      let(:planned_time) { 3 }
      it { is_expected.to be(true) }
    end

    context "after time" do
      let(:planned_time) { 1 }
      it { is_expected.to be(false) }
    end
  end
end
