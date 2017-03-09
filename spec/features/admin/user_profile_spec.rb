# frozen_string_literal: true
describe 'Admin::UserProfile', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:profile) { user.user_profile }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_user_profiles_path }
    it { expect(page_title).to have_content('プロフィール') }
    it { expect(page).to have_content(user.name) }
    it { expect(page).not_to have_content('作成する') }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_user_profile_path(profile) }
    it { expect(page_title).to have_content("##{profile.id}") }
    it { expect(page).to have_content(profile.blood_type_i18n) }
  end

  describe '#update' do
    let(:new_introduction) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_user_profile_path(profile)
      fill_in '自己紹介', with: new_introduction
      click_on 'プロフィールを更新'
    end

    it { expect(page_title).to have_content("##{profile.id}") }
    it { expect(current_path).to eq admin_user_profile_path(profile) }
    it { expect(page).to have_content(new_introduction) }
    it { expect(profile.reload.self_introduction).to eq new_introduction }
  end
end
