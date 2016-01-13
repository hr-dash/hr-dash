# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  status     :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe Tag, type: :model do
  describe 'Validations' do
    subject { build(:tag) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(32) }
  end
end
