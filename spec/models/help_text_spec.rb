describe HelpText, type: :model do
  describe 'Validations' do
    let(:help_text) { build(:help_text) }
    it { expect(help_text).to be_valid }

    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:help_type) }
    it { is_expected.to validate_presence_of(:target) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
