# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  group_id               :integer
#  employee_code          :string
#  email                  :string
#  entry_date             :date
#  beginner_flg           :boolean
#  deleted_at             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  gender                 :integer          default(0), not null
#

describe User, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :group }
    it { is_expected.to have_many :monthly_reports }
    it { is_expected.to have_many :monthly_report_comments }
    it { is_expected.to have_one :user_profile }
    it { is_expected.to have_one :role }
  end

  describe 'Validations' do
    subject { build(:user) }

    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(32) }
    it { is_expected.to validate_presence_of(:employee_code) }
    it { is_expected.to validate_uniqueness_of(:employee_code) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:entry_date) }
    it { is_expected.to validate_presence_of(:gender) }
  end

  describe 'After create' do
    let(:user) { create(:user) }
    let(:profile) { UserProfile.find_by(user_id: user) }
    it { expect(profile).to be_present }
  end

  describe '#report_registrable_months' do
    let(:entry_date) { Date.new(2016, 1, 1) }
    let(:user) { create(:user, entry_date: entry_date) }

    before { Timecop.freeze(today) }
    after { Timecop.return }
    subject { user.report_registrable_months }

    context 'when cannot regist this month report' do
      let(:today) { Date.new(2016, 5, 26) }
      it { expect(subject.first).to eq entry_date }
      it { expect(subject.size).to eq 4 }
      it { expect(subject.last).to eq Date.new(2016, 4, 1) }
    end

    context 'when can regist this month report' do
      let(:today) { Date.new(2016, 5, 27) }
      it { expect(subject.first).to eq entry_date }
      it { expect(subject.size).to eq 5 }
      it { expect(subject.last).to eq Date.new(2016, 5, 1) }
    end
  end
end
