# == Schema Information
#
# Table name: monthly_report_tags
#
#  id                :integer          not null, primary key
#  monthly_report_id :integer          not null
#  tag_id            :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

describe MonthlyReportTag, type: :model do
  it { expect(subject).to respond_to(:id) }
  it { expect(subject).to respond_to(:monthly_report_id) }
  it { expect(subject).to respond_to(:tag_id) }

  let(:report_tag) do
    MonthlyReportTag.create(
      monthly_report_id: report_id,
      tag_id: tag_id
    )
  end
  let(:report_id) { 1 }
  let(:tag_id) { 1 }

  describe '.new' do
    context 'correct params' do
      it { expect(report_tag).to be_valid }
    end

    context 'incorrect params ' do
      context 'monthly report id is string' do
        let(:report_id) { 'one' }
        it { expect(report_tag).not_to be_valid }
      end

      context 'tag id is string' do
        let(:tag_id) { 'one' }
        it { expect(report_tag).not_to be_valid }
      end
    end
  end
end
