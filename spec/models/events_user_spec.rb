# frozen_string_literal: true
require "rails_helper"

RSpec.describe EventsUser, type: :model do
  describe "Active Record Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end
end
