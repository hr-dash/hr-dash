# frozen_string_literal: true

describe 'Admin::UserRole', type: :feature do
  before { login(admin: true) }
  let(:user) { create(:user) }
  let!(:role) { create(:user_role, :admin, user: user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_user_roles_path }
    it 'should open the index page' do
      expect(page_title).to have_content('ロール')
      expect(page).to have_content(user.name)
      expect(page).to have_content('作成する')
      expect(page).to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_user_role_path(role) }
    it { expect(page).to have_content(user.name) }
  end

  describe '#create' do
    let!(:new_user) { create(:user) }
    before do
      visit new_admin_user_role_path
      select new_user.name, from: 'ユーザー'
      select '管理者', from: 'ロール'
      click_on 'ロールを作成'
    end

    it 'should create the new user role' do
      expect(page).to have_content(new_user.name)
      expect(current_path).to eq admin_user_role_path(new_user.role)
    end
  end

  describe '#destroy', js: true do
    before do
      visit admin_user_roles_path
      accept_confirm do
        find("#user_role_#{role.id}").find('.delete_link').click
      end
    end

    it 'should destroy the user role' do
      expect(current_path).to eq admin_user_roles_path
      expect(page).not_to have_content(user.name)
      expect { role.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'cannot access if operator' do
    let(:operator) { create(:user) }

    before do
      login(operator, operator: true)
      visit admin_users_path
    end

    it { expect(current_path).to eq admin_root_path }
  end
end
