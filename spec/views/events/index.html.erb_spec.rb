require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      create(:event)
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Subject".to_s, :count => 1
    assert_select "tr>td", :text => "Place".to_s, :count => 1
    assert_select "tr>td", :text => "MyText".to_s, :count => 1
    assert_select "tr>td", :text => nil.to_s, :count => 1
  end
end
