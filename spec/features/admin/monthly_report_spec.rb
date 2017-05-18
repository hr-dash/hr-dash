# frozen_string_literal: true
describe 'Admin::MonthlyReport', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let!(:report) { create(:monthly_report, user: user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_monthly_reports_path }
    it 'should open the index page' do
      expect(page_title).to have_content('月報')
      expect(page).to have_content(user.name)
      expect(page).to have_content(report.shipped_at)
      expect(page).not_to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_monthly_report_path(report) }
    it { expect(page).to have_content(report.business_content) }
  end

  describe '#update' do
    let(:new_summary) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_monthly_report_path(report)
      fill_in 'プロジェクト概要', with: new_summary
      click_on '月報を更新'
    end

    it 'should update the monthly report' do
      expect(page).to have_content(new_summary)
      expect(current_path).to eq admin_monthly_report_path(report)
      expect(report.reload.project_summary).to eq new_summary
    end
  end
end
