require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Active Record Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:place) }
  end

  describe '#editable?' do
    it 'should return true' do
      user = create(:user)
      event = create(:event)
      expect(event.editable?(user)).to be(true)
    end

    it 'should return false' do
      create(:user) # dummy user who actually create event
      user = create(:user2)
      event = create(:event)
      expect(event.editable?(user)).to be(false)
    end
  end
end
