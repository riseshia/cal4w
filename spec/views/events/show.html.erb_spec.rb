require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :subject => "Subject",
      :place => "Place",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/Place/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
