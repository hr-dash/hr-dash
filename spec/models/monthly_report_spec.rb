# == Schema Information
#
# Table name: monthly_reports
#
#  id                   :integer          not null, primary key
#  user_id             :integer          not null
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
  it { expect(subject).to respond_to(:user_id) }
  it { expect(subject).to respond_to(:project_summary) }
  it { expect(subject).to respond_to(:used_technology) }
  it { expect(subject).to respond_to(:responsible_business) }
  it { expect(subject).to respond_to(:business_content) }
  it { expect(subject).to respond_to(:looking_back) }
  it { expect(subject).to respond_to(:next_month_goals) }
  it { expect(subject).to respond_to(:month) }
  it { expect(subject).to respond_to(:year) }

  describe '.create' do
    let(:report) do
      MonthlyReport.new(
        user_id: user_id,
        project_summary: p_summary,
        used_technology: u_tech,
        responsible_business: r_busi,
        business_content: b_cont,
        looking_back: l_back,
        next_month_goals: goals,
        month: month,
        year: year
      )
    end
    let(:user_id) { 1 }
    let(:p_summary) { 'hoge' }
    let(:u_tech) { 'huga' }
    let(:r_busi) { 'foo' }
    let(:b_cont) { 'bar' }
    let(:l_back) { 'mogu' }
    let(:goals) { 'muga' }
    let(:month) { 1 }
    let(:year) { 2020 }

    context 'correct params' do
      it 'is valid with user_id, month, year ' do
        expect(report).to be_valid
      end
    end

    context 'incorrect params' do
      context 'invalid if user id is string' do
        let(:user_id) { 'one' }
        it { expect(report).not_to be_valid }
      end
      context 'invalid if month is out of 1 to 12 ' do
        let(:month) { 0 }
        it { expect(report).not_to be_valid }
      end
      context 'invalid if year is under 2000' do
        let(:year) { 1999 }
        it { expect(report).not_to be_valid }
      end
    end
  end
end
