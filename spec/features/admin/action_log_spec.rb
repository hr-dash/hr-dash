describe 'Admin::HelpText', type: :feature do
  let(:page_title) { find('#page_title') }
  let(:new_group) { build(:group) }
  let(:user) { create(:user) }

  before do
    login(user, admin: true)

    # ActionLogレコード作成の為、サンプルとしてグループを登録
    visit new_admin_group_path
    fill_in '名前', with: new_group.name
    fill_in '説明', with: new_group.description
    click_on 'Create グループ'
  end

  describe '#index' do
    before { visit admin_active_admin_action_logs_path }
    it { expect(page_title).to have_content('Active Admin Action Logs') }
    it { expect(page).to have_content(user.name) }
    it { expect(page).to have_content('Group') }
    it { expect(page).to have_content(new_group.name) }
    it { expect(page).not_to have_content('作成する') }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    let(:log) { ActiveAdminActionLog.where(user: user, resource_type: 'Group').last }

    before do
      visit admin_active_admin_action_logs_path
      find("#active_admin_action_log_#{log.id}").find('.view_link').click
    end

    it { expect(page_title).to have_content("##{log.id}") }
    it { expect(page).to have_content(user.name) }
    it { expect(page).to have_content(log.resource_type) }
    it { expect(page).to have_content(log.path) }
    it { expect(page).to have_content(log.action) }
  end
end
