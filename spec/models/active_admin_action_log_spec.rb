require 'rails_helper'

RSpec.describe ActiveAdminActionLog, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :resource }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:resource) }
    it { is_expected.to validate_presence_of(:path) }
    it { is_expected.to validate_presence_of(:action) }
  end
end
