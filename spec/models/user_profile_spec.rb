require 'rails_helper'

describe UserProfile, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Validations' do
    subject { build(:user_profile) }

    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_presence_of(:blood_type) }
  end
end
