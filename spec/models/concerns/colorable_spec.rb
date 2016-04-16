# frozen_string_literal: true
require "rails_helper"

RSpec.describe Colorable, type: :concern do
  include Colorable

  let(:id) { 1 }

  describe "#to_hex_with" do
    it "will return 1" do
      def id
        1
      end
      expect(to_hex_with).to eq(1)
    end
  end

  describe "#to_hex" do
    it { expect(to_hex).to eq("#CB99C9") }
    it "will return different color" do
      def id
        1
      end
      first_color = to_hex
      def id
        2
      end
      second_color = to_hex
      expect(first_color).not_to eq(second_color)
    end
  end
end
