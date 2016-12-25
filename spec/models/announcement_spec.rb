# == Schema Information
#
# Table name: announcements
#
#  id             :integer          not null, primary key
#  title          :string           not null
#  body           :text             not null
#  published_date :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

describe Announcement, type: :model do
  describe 'Validations' do
    subject { build(:announcement) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:published_date) }
  end
end
