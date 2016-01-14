# == Schema Information
#
# Table name: monthly_reports
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  target_month     :datetime         not null
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
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:target_month) }

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
    describe 'Comments' do
      let!(:report) { create(:monthly_report, :with_comments, comment_size: 3) }
      let!(:comments) { report.monthly_report_comments }
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
end
