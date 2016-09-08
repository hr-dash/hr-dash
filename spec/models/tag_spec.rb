# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  status     :integer          default(0), not null
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

    describe 'VALID_NAME_REGEX' do
      context 'allowed chars' do
        allowed_chars = [
          'a', 'A', '0',
          '_', '.', '+',
          '#', "'", '-',
          'spa ce', 'あ', 'ア', '漢'
        ]

        allowed_chars.each do |c|
          it { is_expected.to allow_value(c).for(:name) }
        end
      end

      context 'not allowed chars' do
        not_allowed_chars = [
          '!', '"', '$', '%', '&',
          '(', ')', '=', '~', '?',
          '|', '@', '`', '{', '}',
          '*', ';', ',', ':', '/'
        ]

        not_allowed_chars.each do |c|
          it { is_expected.not_to allow_value(c).for(:name) }
        end
      end
    end
  end
end
