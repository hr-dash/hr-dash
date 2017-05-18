# frozen_string_literal: true
describe 'Admin::UserProfile', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:profile) { user.user_profile }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_user_profiles_path }
    it 'should open the index page' do
      expect(page_title).to have_content('プロフィール')
      expect(page).to have_content(user.name)
      expect(page).not_to have_content('作成する')
      expect(page).not_to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_user_profile_path(profile) }
    it 'should open the show page' do
      expect(page_title).to have_content("##{profile.id}")
      expect(page).to have_content(profile.blood_type_i18n)
    end
  end

  describe '#update' do
    let(:new_introduction) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_user_profile_path(profile)
      fill_in '自己紹介', with: new_introduction
      click_on 'プロフィールを更新'
    end

    it 'should update introduction of user profile' do
      expect(page_title).to have_content("##{profile.id}")
      expect(current_path).to eq admin_user_profile_path(profile)
      expect(page).to have_content(new_introduction)
      expect(profile.reload.self_introduction).to eq new_introduction
    end
  end
end
