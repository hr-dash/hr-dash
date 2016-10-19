# == Schema Information
#
# Table name: user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe UserRole, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Validations' do
    subject { build(:user_role) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to define_enum_for(:role) }
  end
end
