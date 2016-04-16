# frozen_string_literal: true
require "rails_helper"

RSpec.describe User, type: :model do
  describe "Active Record Associations" do
    it { expect have_many(:events_users) }
    it { should have_many(:events).through(:events_users) }
  end

  describe "Active Record Validations" do
    it { should validate_presence_of(:provider) }
  end
end
