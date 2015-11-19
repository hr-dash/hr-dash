# == Schema Information
#
# Table name: monthly_report_comments
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  comment           :text
#  monthly_report_id :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

describe MonthlyReportComment, type: :model do
  it { expect(subject).to respond_to(:id) }
  it { expect(subject).to respond_to(:user_id) }
  it { expect(subject).to respond_to(:comment) }
  it { expect(subject).to respond_to(:monthly_report_id) }

  let(:report_comment) do
    MonthlyReportComment.new(
      user_id: user_id,
      comment: comment,
      monthly_report_id: report_id
    )
  end
  let(:user_id) { 1 }
  let(:comment) { 'hogehoge' }
  let(:report_id) { 1 }

  describe '.new' do
    context 'correct params' do
      it { expect(report_comment).to be_valid }
    end

    context 'incorrect params' do
      context 'invalid if user_id is string'do
        let(:user_id) { 'one' }
        it { expect(report_comment).not_to be_valid }
      end

      context 'invalid if monthly report id is string ' do
        let(:report_id) { 'one' }
        it { expect(report_comment).not_to be_valid }
      end
    end
  end
end
