# frozen_string_literal: true
require "rails_helper"

RSpec.describe User, type: :model do
  describe "Active Record Validations" do
    it { should validate_presence_of(:provider) }
  end
end
