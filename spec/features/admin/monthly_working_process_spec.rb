# frozen_string_literal: true
describe 'Admin::MonthlyWorkingProcess', type: :feature do
  let(:page_title) { find('#page_title') }
  let!(:working_process) { create(:monthly_working_process) }
  let(:user) { working_process.monthly_report.user }

  before { login(admin: true) }

  describe '#index' do
    before { visit admin_monthly_working_processes_path }
    it { expect(page_title).to have_content('月別担当業務') }
    it { expect(page).to have_content(user.name) }
    it { expect(page).not_to have_content('作成する') }
    it { expect(page).to have_content('閲覧') }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_monthly_working_process_path(working_process) }
    it { expect(page_title).to have_content("##{working_process.id}") }
  end
end
