# == Schema Information
#
# Table name: monthly_reports
#
#  id                   :integer          not null, primary key
#  user_id              :integer          not null
#  project_summary      :text
#  used_technology      :text
#  responsible_business :text
#  business_content     :text
#  looking_back         :text
#  next_month_goals     :text
#  month                :integer          not null
#  year                 :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'rails_helper'

RSpec.describe MonthlyReport, type: :model do
  describe 'Validations' do
    subject { build(:monthly_report) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:month) }
    it { is_expected.to validate_inclusion_of(:month).in_range(1..12) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_numericality_of(:year).is_greater_than_or_equal_to(2000) }
  end

  describe 'Relations' do
    let(:report) { create(:monthly_report) }

    describe 'Comments' do
      let!(:comments) { create_list(:monthly_report_comment, 3, monthly_report: report) }
      it { expect(report.monthly_report_comments.size).to eq 3 }

      context 'When report destroyed' do
        before { report.destroy }
        it { expect { comments.sample.reload }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end
  end
end
