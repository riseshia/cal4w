require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Active Record Validations' do
    it { should validate_presence_of(:provider) }
  end

  describe '#nickname' do
    it 'should start with "@"' do
      user = create(:user)
      expect(user.nickname.start_with?('@')).to be(true)
    end
  end
end
