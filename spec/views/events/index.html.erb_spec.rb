# frozen_string_literal: false
require "rails_helper"

RSpec.describe "events/index", type: :view do
  before(:each) do
    create(:user)
    assign(:events, [
             create(:event)
           ])
  end

  it "renders a list of events" do
    render
    assert_select "a", text: "Subject in Place".to_s, count: 1
  end
end
