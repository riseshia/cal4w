# frozen_string_literal: true
require "rails_helper"

RSpec.describe EventUser, type: :model do
  describe "Active Record Associations" do
    it { expect belong_to(:user) }
    it { expect belong_to(:event) }
  end
end
