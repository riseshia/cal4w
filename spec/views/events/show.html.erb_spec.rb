# frozen_string_literal: false
require "rails_helper"

RSpec.describe "events/show", type: :view do
  context "User is creator" do
    before(:each) do
      assign(:user, create(:user))
      event = assign(:event, create(:event))
      new_member = create(:user2)
      event.members << new_member
    end

    it "renders attributes in <p>" do
      render
      expect(rendered).to match(/Subject/)
      expect(rendered).to match(/Place/)
      expect(rendered).to match(/MyText/)
      expect(rendered).to match(//)
      expect(rendered).to match(/Who will come?/)
    end
  end

  context "User is not joined and not creator" do
    before(:each) do
      create(:user)
      assign(:user, create(:user2))
      assign(:event, create(:event))
    end

    it "renders attributes" do
      render
      expect(rendered).to match(/Subject/)
      expect(rendered).to match(/Place/)
      expect(rendered).to match(/MyText/)
      expect(rendered).to match(//)
      expect(rendered).to match(/Join/)
    end
  end

  context "User is joined and not creator" do
    before(:each) do
      create(:user)
      event = create(:event)
      new_member = create(:user2)
      assign(:user, new_member)
      assign(:event, event)
      event.members << new_member
    end

    it "renders attributes" do
      render
      expect(rendered).to match(/Subject/)
      expect(rendered).to match(/Place/)
      expect(rendered).to match(/MyText/)
      expect(rendered).to match(//)
      expect(rendered).to match(/I cannot go T-T/)
    end
  end
end
