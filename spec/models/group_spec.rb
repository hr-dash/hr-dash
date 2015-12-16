# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe Group, type: :model do
  describe 'Relations' do
    it { is_expected.to have_many :users }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
