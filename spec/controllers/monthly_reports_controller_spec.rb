require 'rails_helper'

describe MonthlyReportsController, type: :controller, monthly_report: true do
  include Devise::TestHelpers

  describe '#new' do
    context 'Case last month of the monthly report has been registered' do
      let(:monthly_report_t) { create(:monthly_report_tag) }
      let(:next_month) { month_report_attributes['target_month'].next_month }
      let(:user) { monthly_report_t.monthly_report.user }
      let(:params) { { target_month: next_month.to_s } }
      let(:expected) { MonthlyReport.new(month_report_attributes).attributes }
      let(:month_report_attributes) do
        monthly_report_t.monthly_report.attributes.select do |key, _|
          %w(user_id project_summary business_content looking_back next_month_goals target_month).include? key
        end
      end

      before do
        expected['target_month'] = next_month
        sign_in user
        get :new, params
      end

      it { expect(assigns[:monthly_report].attributes).to eq expected }
      it { expect(assigns[:monthly_report].tags.first.attributes).to eq monthly_report_t.tag.attributes }
      it { expect(assigns[:monthly_report].tags.size).to eq 1 }
    end

    context 'Case last month of the monthly report is not registered' do
      let(:user) { create(:user) }
      let(:target_month) { Time.current.last_month.beginning_of_month }
      let(:params) { { target_month: target_month.to_s } }
      let(:expected_monthly_attr) do
        MonthlyReport.new('target_month' => target_month, 'user_id' => user.id).attributes
      end

      before do
        MonthlyReport.destroy_all(target_month: target_month.prev_month)
        sign_in user
        get :new, params
      end

      it { expect(assigns[:monthly_report].attributes).to eq expected_monthly_attr }
      it { expect(assigns[:monthly_report].tags).to be_empty }
    end
  end
end
