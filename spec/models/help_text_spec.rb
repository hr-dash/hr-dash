# frozen_string_literal: true
# == Schema Information
#
# Table name: help_texts
#
#  id         :integer          not null, primary key
#  category   :string
#  help_type  :string
#  target     :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe HelpText, type: :model do
  describe 'Validations' do
    let(:help_text) { build(:help_text) }
    it { expect(help_text).to be_valid }

    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:help_type) }
    it { is_expected.to validate_presence_of(:target) }
    it { is_expected.to validate_presence_of(:body) }
  end

  describe '.placeholders' do
    let!(:help_text) { create(:help_text, :placeholder) }
    subject { described_class.placeholders(category) }

    context 'match category' do
      let(:category) { help_text.category }
      let(:target) { help_text.target }
      let(:body) { help_text.body }
      let(:result) { { target.to_sym => body } }
      it { is_expected.not_to be_blank }
      it { is_expected.to eq result }
    end

    context 'not match category' do
      let(:category) { 'invalid category' }
      let(:result) { {} }
      it { is_expected.to be_blank }
      it { is_expected.to eq result }
    end
  end

  describe '.hints' do
    let!(:help_text) { create(:help_text, :hint) }
    subject { described_class.hints(category) }

    context 'match category' do
      let(:category) { help_text.category }
      let(:target) { help_text.target }
      let(:body) { help_text.body }
      let(:result) { { target.to_sym => body } }
      it { is_expected.not_to be_blank }
      it { is_expected.to eq result }
    end

    context 'not match category' do
      let(:category) { 'invalid category' }
      let(:result) { {} }
      it { is_expected.to be_blank }
      it { is_expected.to eq result }
    end
  end
end
