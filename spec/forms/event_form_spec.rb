# frozen_string_literal: true
require "rails_helper"

# Type is 'model' to get support from shoulda
RSpec.describe EventForm, type: :model do
  describe "Active Record Validations" do
    it { expect validate_presence_of(:title) }
    it { expect validate_presence_of(:place) }
    it { expect validate_presence_of(:start_time) }
    it { expect validate_presence_of(:planned_time) }
    it { expect validate_presence_of(:timezone_offset) }
    it { expect validate_numericality_of(:planned_time) }
  end

  describe "Timezone validations" do
    let(:user) { create(:user) }
    let(:event_attr) do
      { :title => "test",
        :place => "asdfasd",
        :description => "<p>asdf</p>",
        "start_time(1i)" => "2020",
        "start_time(2i)" => "8",
        "start_time(3i)" => "19",
        "start_time(4i)" => "21",
        "start_time(5i)" => "00",
        :planned_time => "1" }
    end

    it "returns 20:00 +0900 from 21:00 +1000 with params" do
      event_form = EventForm.init_with_params(event_attr)
      event_form.valid?
      expected_datetime = Time.new(2020, 8, 19, 21, 0, 0, "+00:00")
      expect(event_form.start_time).to eq(expected_datetime)
    end

    it "returns 21:00 from 21:00 +1000 with event" do
      event = build(:event,
                    start_time: Time.new(2020, 8, 19, 21, 0, 0, "+00:00"))
      event_form = EventForm.init_with_event(event)
      expected_datetime = Time.zone.local(2020, 8, 19, 21, 0, 0)
      expect(event_form.start_time).to eq(expected_datetime)
    end
  end
end
