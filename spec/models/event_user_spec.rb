# frozen_string_literal: true
require "rails_helper"

RSpec.describe EventUser, type: :model do
  describe "Active Record Associations" do
    it { expect belong_to(:user) }
    it { expect belong_to(:event) }
  end

  describe "Active Record Validations" do
    context "uniqueness check" do
      let(:event_user) do
        user = create(:user)
        event = create(:event)
        event.members << user
        EventUser.new(user_id: user.id, event_id: event.id)
      end

      subject { event_user.valid? }
      it { is_expected.to be(false) }
    end
  end
end
