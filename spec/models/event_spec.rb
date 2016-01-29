require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Active Record Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:place) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:finish_time) }
  end

end
