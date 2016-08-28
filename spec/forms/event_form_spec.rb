# frozen_string_literal: true
require "rails_helper"

# Type is 'model' to get support from shoulda
RSpec.describe EventForm, type: :model do
  describe "Active Record Validations" do
    it { expect validate_presence_of(:subject) }
    it { expect validate_presence_of(:place) }
    it { expect validate_presence_of(:start_time) }
    it { expect validate_presence_of(:planned_time) }
    it { expect validate_presence_of(:timezone_offset) }
    it { expect validate_numericality_of(:planned_time) }
  end

  describe "Timezone validations" do
    let(:user) { create(:user) }
    let(:event_attr) do
      { :subject => "test",
        :place => "asdfasd",
        :description => "<p>asdf</p>",
        "start_time(1i)" => "2020",
        "start_time(2i)" => "8",
        "start_time(3i)" => "19",
        "start_time(4i)" => "21",
        "start_time(5i)" => "00",
        :timezone_offset => "-600",
        :planned_time => "1" }
    end

    it "returns 20:00 +0900 from 21:00 +1000 with params" do
      event_form = EventForm.new(event_attr)
      event_form.valid?
      actual = event_form.attributes
      expected_datetime = Time.new(2020, 8, 19, 21, 0, 0, "+10:00")
      expect(actual[:start_time]).to eq(expected_datetime)
    end

    it "returns 21:00 from 21:00 +1000 with event" do
      event = build(:event,
                    start_time: Time.new(2020, 8, 19, 21, 0, 0, "+10:00"),
                    timezone_offset: -600)
      event_form = EventForm.init_with_event(event)
      actual = event_form.attributes
      expected_datetime = Time.zone.local(2020, 8, 19, 21, 0, 0)
      expect(actual[:start_time]).to eq(expected_datetime)
    end
  end

  describe "#valid?" do
    it "returns true with future date" do
      event = build(:event, start_time: 1.minute.from_now)
      event_form = EventForm.init_with_event(event)
      expect(event_form).to be_valid
    end

    it "returns false with past date" do
      event = build(:event, start_time: 1.minute.ago)
      event_form = EventForm.init_with_event(event)
      expect(event_form).not_to be_valid
    end
  end
end
