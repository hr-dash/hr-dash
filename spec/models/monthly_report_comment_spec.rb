# frozen_string_literal: true

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
  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :monthly_report }
  end

  describe 'Validations' do
    subject { build(:monthly_report_comment) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:monthly_report) }
    it { is_expected.to validate_presence_of(:comment) }
    it { is_expected.to validate_length_of(:comment).is_at_most(3000) }
  end
end
