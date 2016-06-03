# frozen_string_literal: true
require "rails_helper"

# Type is 'model' to get support from shoulda
RSpec.describe EventForm, type: :model do
  describe "Active Record Validations" do
    it { expect validate_presence_of(:subject) }
    it { expect validate_presence_of(:place) }
    it { expect validate_presence_of(:start_time) }
    it { expect validate_presence_of(:planned_time) }
    it { expect validate_numericality_of(:planned_time) }
  end
end
