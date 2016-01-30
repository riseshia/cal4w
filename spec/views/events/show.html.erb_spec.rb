require 'rails_helper'

RSpec.describe 'events/show', type: :view do
  before(:each) do
    assign(:user, create(:user))
    assign(:event, create(:event))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/Place/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
