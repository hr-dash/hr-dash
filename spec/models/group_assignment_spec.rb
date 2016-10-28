# == Schema Information
#
# Table name: group_assignments
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe GroupAssignment, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :group }
    it { is_expected.to belong_to :user }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:group) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
