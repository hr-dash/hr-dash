# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  employee_code          :string
#  encrypted_email        :string           not null
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
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  gender                 :integer          default(0), not null
#

describe User, type: :model do
  describe 'Relations' do
    it { is_expected.to have_many :groups }
    it { is_expected.to have_many :group_assignments }
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
    it { is_expected.to validate_presence_of(:encrypted_email) }
    it { is_expected.to validate_presence_of(:entry_date) }
    it { is_expected.to validate_presence_of(:gender) }

    describe '#secure_password' do
      it { is_expected.not_to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(72) }

      context 'valid_passwords' do
        valid_passwords = %w(
          Passw0rd
          aA1#$%&@'()/*+.=-
        )

        valid_passwords.each do |password|
          it { is_expected.to allow_value(password).for(:password) }
        end
      end

      context 'invalid_passwords' do
        invalid_passwords = %w(
          ABCD1234
          1a2b3c4d
          aAzZ@bBcC
        )

        invalid_passwords.each do |password|
          it { is_expected.not_to allow_value(password).for(:password) }
        end
      end
    end
  end

  describe 'After create' do
    let(:user) { create(:user) }
    let(:profile) { UserProfile.find_by(user: user) }
    it { expect(profile).to be_present }
  end

  describe '.active' do
    let!(:user) { create(:user, deleted_at: deleted_at) }
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

  describe '#report_registrable_months' do
    let(:entry_date) { Date.new(2016, 1, 1) }
    let(:user) { create(:user, entry_date: entry_date) }
    let(:now_str) { "#{today}T000000+0900" }
    let(:now) { Time.strptime(now_str, '%Y%m%dT%H%M%S%z') }

    before { Timecop.freeze(now) }
    after { Timecop.return }
    subject { user.report_registrable_months }

    context 'when cannot regist this month report' do
      context 'short month' do
        let(:today) { '20160425' }
        it { expect(subject.first).to eq entry_date }
        it { expect(subject.size).to eq 3 }
        it { expect(subject.last).to eq Date.new(2016, 3, 1) }
      end

      context 'long month' do
        let(:today) { '20160526' }
        it { expect(subject.first).to eq entry_date }
        it { expect(subject.size).to eq 4 }
        it { expect(subject.last).to eq Date.new(2016, 4, 1) }
      end
    end

    context 'when can regist this month report' do
      context 'short month' do
        let(:today) { '20160426' }
        it { expect(subject.first).to eq entry_date }
        it { expect(subject.size).to eq 4 }
        it { expect(subject.last).to eq Date.new(2016, 4, 1) }
      end

      context 'long month' do
        let(:today) { '20160527' }
        it { expect(subject.first).to eq entry_date }
        it { expect(subject.size).to eq 5 }
        it { expect(subject.last).to eq Date.new(2016, 5, 1) }
      end
    end
  end

  describe '#active_for_authentication?' do
    let(:user) { create(:user, deleted_at: deleted_at) }
    let(:today) { Time.current.to_date }
    subject { user.active_for_authentication? }

    context 'active' do
      context 'deleted_at is nil' do
        let(:deleted_at) { nil }
        it { is_expected.to be true }
      end

      context 'deleted_at is after today' do
        let(:deleted_at) { today + 1.day }
        it { is_expected.to be true }
      end
    end

    context 'inactive' do
      context 'deleted_at is before today' do
        let(:deleted_at) { today - 1.day }
        it { is_expected.to be false }
      end

      context 'deleted_at is today' do
        let(:deleted_at) { today }
        it { is_expected.to be false }
      end
    end
  end

  pending 'To merge a branch of Dev/262 use same class for date' do
    describe '.report_registrable_to' do
      let(:entry_date) { Date.new(2016, 1, 1) }
      let(:user) { create(:user, entry_date: entry_date) }

      before { Timecop.freeze(today) }
      after { Timecop.return }
      subject { User.report_registrable_to }

      context 'when end of the month before than 5 days' do
        let(:today) { Date.new(2016, 5, 26) }
        it { expect(subject).to eq Date.new(2016, 4, 30) }
      end

      context 'when end of the month 5 days before or later' do
        let(:today) { Date.new(2016, 5, 27) }
        it { expect(subject).to eq Date.new(2016, 5, 1) }
      end
    end
  end
end
