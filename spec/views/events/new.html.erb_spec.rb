require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :subject => "MyString",
      :place => "MyString",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_subject[name=?]", "event[subject]"

      assert_select "input#event_place[name=?]", "event[place]"

      assert_select "textarea#event_description[name=?]", "event[description]"

      assert_select "input#event_user_id[name=?]", "event[user_id]"
    end
  end
end
