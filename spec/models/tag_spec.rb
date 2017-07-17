# frozen_string_literal: true
# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  status     :integer          default("unfixed"), not null
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

  describe '.find_or_initialize_by_name_ignore_case' do
    let!(:tag) { create(:tag, name: 'Ruby') }
    subject { Tag.find_or_initialize_by_name_ignore_case(name) }

    context 'exactly match' do
      let(:name) { 'Ruby' }
      it { is_expected.to eq tag }
      it { is_expected.not_to be_new_record }
    end

    context 'match in ignore case' do
      let(:name) { 'ruby' }
      it { is_expected.to eq tag }
      it { is_expected.not_to be_new_record }
    end

    context 'not match' do
      let(:name) { 'Rails' }
      it { is_expected.not_to eq tag }
      it { is_expected.to be_new_record }
    end
  end
end
