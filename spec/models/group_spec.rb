# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  email       :string           not null
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

describe Group, type: :model do
  describe 'Relations' do
    it { is_expected.to have_many :users }
    it { is_expected.to have_many :group_assignments }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '.active' do
    let!(:group) { create(:group, deleted_at: deleted_at) }
    subject { described_class.active.present? }

    context 'when deleted_at is nil' do
      let(:deleted_at) { nil }
      it { is_expected.to eq true }
    end

    context 'when deleted_at is future' do
      let(:deleted_at) { Time.current.tomorrow }
      it { is_expected.to eq true }
    end

    context 'when deleted_at is past' do
      let(:deleted_at) { Time.current.yesterday }
      it { is_expected.to eq false }
    end
  end
end
