describe 'Admin::MonthlyReport', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let!(:report) { create(:monthly_report, user: user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_monthly_reports_path }
    it { expect(page_title).to have_content('月報') }
    it { expect(page).to have_content(user.name) }
    it { expect(page).to have_content(report.shipped_at) }
    it { expect(page).not_to have_css('.delete_link') }
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

    it { expect(page).to have_content(new_summary) }
    it { expect(current_path).to eq admin_monthly_report_path(report) }
    it { expect(report.reload.project_summary).to eq new_summary }
  end
end
