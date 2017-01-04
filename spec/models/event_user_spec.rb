# frozen_string_literal: true
require "rails_helper"

RSpec.describe EventUser, type: :model do
  describe "Active Record Associations" do
    it { expect belong_to(:user) }
    it { expect belong_to(:event) }
  end

  describe "Active Record Validations" do
    context "uniqueness check" do
      it "returns false" do
        user = create(:user)
        event = create(:event)
        event.members << user
        event_user = EventUser.new(user_id: user.id, event_id: event.id)
        expect(event_user.valid?).to be(false)
      end
    end
  end
end
