# == Schema Information
#
# Table name: monthly_reports
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  target_month     :date             not null
#  status           :integer          not null
#  shipped_at       :datetime
#  project_summary  :text
#  business_content :text
#  looking_back     :text
#  next_month_goals :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

RSpec.describe MonthlyReport, type: :model do
  describe 'Validations' do
    subject { build(:monthly_report) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:target_month) }
    it { is_expected.to validate_length_of(:project_summary).is_at_most(5000) }
    it { is_expected.to validate_length_of(:business_content).is_at_most(5000) }
    it { is_expected.to validate_length_of(:looking_back).is_at_most(5000) }
    it { is_expected.to validate_length_of(:next_month_goals).is_at_most(5000) }

    describe '#target_beginning_of_month?' do
      let(:invalid_target) { Faker::Date.backward(100).end_of_month }
      let(:monthly_report) { build(:monthly_report, target_month: invalid_target) }

      it { expect(monthly_report).not_to be_valid }
    end

    describe '#target_month_registrable_term' do
      let(:monthly_report) { build(:monthly_report, target_month: invalid_target) }

      context 'before lower limit' do
        let(:lower_limit) { Time.local(2000, 1, 1) }
        let(:invalid_target) { lower_limit.ago(1.day) }
        it { expect(monthly_report).not_to be_valid }
      end

      context 'after higher limit' do
        let(:invalid_target) { Time.current }
        it { expect(monthly_report).not_to be_valid }
      end
    end
  end

  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :monthly_report_tags }
    it { is_expected.to have_many :tags }
    it { is_expected.to have_many :monthly_working_processes }

    describe 'Comments' do
      let!(:report) { create(:monthly_report, :with_comments, comment_size: 3) }
      let!(:comments) { report.comments }
      it { expect(comments.size).to eq 3 }

      context 'When report destroyed' do
        before { report.destroy }
        it { expect(comments.size).to eq 0 }
      end
    end

    describe 'Tags' do
      let!(:report) { create(:monthly_report, :with_tags, tag_size: 3) }
      let!(:report_tags) { report.monthly_report_tags }
      let!(:tags) { report.tags }
      it { expect(report_tags.size).to eq 3 }
      it { expect(tags.size).to eq 3 }

      context 'When report destroyed' do
        before { report.destroy }
        it { expect(report_tags.size).to eq 0 }
        it { expect(Tag.all.size).to eq 3 }
      end
    end
  end

  describe 'Callbacks' do
    describe '#log_shipped_at' do
      context 'wip' do
        let(:report) { create(:monthly_report, :wip) }
        it { expect(report.shipped_at).to be nil }
      end

      context 'shipped' do
        let(:report) { create(:monthly_report, :shipped) }
        it { expect(report.shipped_at).not_to be nil }
      end
    end
  end

  describe '#this_month_goals' do
    let(:user) { create(:user) }
    let(:report) { create(:monthly_report, user: user) }
    subject { report.this_month_goals }

    context 'not exist last month report' do
      it { is_expected.to be_nil }
    end

    context 'exist last month report' do
      let(:last_month) { report.target_month.prev_month }
      before { create(:monthly_report, user: user, target_month: last_month) }

      it { is_expected.not_to be_nil }
    end
  end

  describe '#set_prev_monthly_report!' do
    let(:user) { create(:user) }
    let(:report) { MonthlyReport.new(target_month: Date.today.beginning_of_month, user: user) }
    subject { report.set_prev_monthly_report! }

    context 'not exist last month report' do
      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end

    context 'exist last month report' do
      before { create(:monthly_report, target_month: report.target_month.last_month, user: user) }
      it { expect { subject }.not_to raise_error }
    end
  end
end
