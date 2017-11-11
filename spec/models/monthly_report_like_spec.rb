# frozen_string_literal: true
# == Schema Information
#
# Table name: monthly_report_likes
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  monthly_report_id :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

describe MonthlyReportLike, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :monthly_report }
  end

  describe 'Validations' do
    subject { build(:monthly_report_like) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:monthly_report) }

    # このバグを踏んだようです
    # https://github.com/thoughtbot/shoulda-matchers/issues/814
    #
    # it { is_expected.to validate_uniqueness_of(:user, scope: :monthly_report) }
  end

  describe 'Uniqueness Validation' do
    subject { MonthlyReportLike.new(user: user, monthly_report: monthly_report) }
    let(:like) { create(:monthly_report_like) }
    let(:user) { like.user }
    let(:monthly_report) { like.monthly_report }

    context 'when user and monthly_report are the same' do
      it { is_expected.not_to be_valid }
    end

    context 'when user is the same and monthly_report is not the same' do
      let(:monthly_report) { build(:monthly_report) }
      it { is_expected.to be_valid }
    end

    context 'when user is not the same and monthly_report is the same' do
      let(:user) { build(:user) }
      it { is_expected.to be_valid }
    end
  end
end
