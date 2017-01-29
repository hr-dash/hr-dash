# == Schema Information
#
# Table name: monthly_reports
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  target_month     :date             not null
#  shipped_at       :datetime
#  project_summary  :text
#  business_content :text
#  looking_back     :text
#  next_month_goals :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comments_count   :integer          default(0), not null
#

RSpec.describe MonthlyReport, type: :model do
  describe 'Validations' do
    shared_examples 'common validations' do
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:target_month) }
      it { is_expected.to validate_length_of(:project_summary).is_at_most(5000) }
      it { is_expected.to validate_length_of(:business_content).is_at_most(5000) }
      it { is_expected.to validate_length_of(:looking_back).is_at_most(5000) }
      it { is_expected.to validate_length_of(:next_month_goals).is_at_most(5000) }
    end

    context 'when report is wip' do
      subject { build(:monthly_report) }
      it { is_expected.to be_valid }
      it_behaves_like 'common validations'
    end

    context 'when report is shipped' do
      subject { build(:shipped_monthly_report) }
      it { is_expected.to be_valid }
      it_behaves_like 'common validations'

      it { is_expected.to validate_presence_of(:project_summary) }
      it { is_expected.to validate_presence_of(:business_content) }
      it { is_expected.to validate_presence_of(:looking_back) }
      it { is_expected.to validate_presence_of(:next_month_goals) }
      it { is_expected.to validate_presence_of(:monthly_working_process) }
      it { is_expected.to validate_presence_of(:monthly_report_tags) }
    end

    describe '#target_beginning_of_month?' do
      let(:invalid_target) { Faker::Date.backward(100).end_of_month }
      let(:monthly_report) { build(:monthly_report, target_month: invalid_target) }

      it { expect(monthly_report).not_to be_valid }
    end

    describe '#target_month_registrable_term' do
      let(:user) { create(:user) }
      let(:monthly_report) { build(:monthly_report, user: user, target_month: invalid_target) }

      context 'before lower limit' do
        let(:lower_limit) { user.entry_date.beginning_of_month }
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
    it { is_expected.to have_one :monthly_working_process }

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

  describe '.of_latest_month_registered_by' do
    let(:user) { create(:user) }

    context 'when reprot exists' do
      let(:last_month_1st_day) { User.report_registrable_to.beginning_of_month }
      let!(:monthly_report) { create(:monthly_report, user: user, target_month: last_month_1st_day) }
      let(:latest_report) { MonthlyReport.of_latest_month_registered_by user }

      it { expect(latest_report).not_to be nil }
    end

    context 'when report doesn`t exist' do
      let(:latest_report) { MonthlyReport.of_latest_month_registered_by user }

      it { expect(latest_report).to be nil }
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
      before { create(:shipped_monthly_report, target_month: report.target_month.last_month, user: user) }
      it { expect { subject }.not_to raise_error }
    end
  end

  describe '#shipped!' do
    let(:report) { build(:monthly_report) }

    context 'wip' do
      it { expect(report.shipped_at).to be nil }
    end

    context 'shipped' do
      before { report.shipped! }

      context 'at first time' do
        it { expect(report.shipped_at).not_to be nil }
      end

      context 'after second time' do
        let(:tomorrow) { Time.current.tomorrow }

        before do
          Timecop.freeze(tomorrow) do
            report.shipped!
          end
        end

        it { expect(report.shipped_at).not_to be nil }
        it { expect(report.shipped_at).not_to eq tomorrow }
      end
    end
  end

  describe '#shipped?' do
    context 'wip' do
      let(:report) { build(:monthly_report, :wip) }
      it { expect(report).not_to be_shipped }
    end

    context 'shipped' do
      let(:report) { build(:monthly_report, :shipped) }
      it { expect(report).to be_shipped }
    end
  end

  describe '#related_users' do
    let(:report) { create(:monthly_report, :shipped, :with_tags, user: user) }
    let(:user) { create(:user) }
    let(:comment_user1) { create(:user) }
    let(:comment_user2) { create(:user) }
    subject { report.related_users }

    context 'only report user' do
      it { is_expected.to match_array([user]) }
    end

    context 'commented one user' do
      before { create(:monthly_report_comment, monthly_report: report, user: comment_user1) }
      it { is_expected.to match_array([user, comment_user1]) }
    end

    context 'commented two user and one commented twice' do
      before do
        2.times { create(:monthly_report_comment, monthly_report: report, user: comment_user1) }
        create(:monthly_report_comment, monthly_report: report, user: comment_user2)
      end

      it { is_expected.to match_array([user, comment_user1, comment_user2]) }
    end
  end
end
