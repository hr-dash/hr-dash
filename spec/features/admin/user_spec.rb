describe 'Admin::User', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_users_path }
    it { expect(page_title).to have_content('ユーザ') }
    it { expect(page).to have_content(user.name) }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_user_path(user) }
    it { expect(page_title).to have_content(user.name) }
    it { expect(page).to have_content(user.group.name) }
  end

  describe '#create' do
    pending
  end

  describe '#update' do
    let(:new_name) { Faker::Name.name }
    before do
      visit edit_admin_user_path(user)
      fill_in '名前', with: new_name
      click_on 'Update ユーザー'
    end

    it { expect(page_title).to have_content(new_name) }
    it { expect(user.reload.name).to eq new_name }
    it { expect(current_path).to eq admin_user_path(user) }
  end
end
