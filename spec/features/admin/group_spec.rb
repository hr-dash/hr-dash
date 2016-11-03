describe 'Admin::Group', type: :feature do
  before { login(admin: true) }
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let!(:assignment) { create(:group_assignment, group: group, user: user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_groups_path }
    it { expect(page_title).to have_content('グループ') }
    it { expect(page).to have_content(group.name) }
    it { expect(page).to have_content('作成する') }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_group_path(group) }
    it { expect(page_title).to have_content(group.name) }
    it { expect(page).to have_content(user.name) }
  end

  describe '#create' do
    let(:new_group) { build(:group) }
    before do
      visit new_admin_group_path
      fill_in '名前', with: new_group.name
      fill_in 'メールアドレス', with: new_group.email
      fill_in '説明', with: new_group.description
      click_on 'Create グループ'
    end

    it { expect(page_title).to have_content(new_group.name) }
    it { expect(page).to have_content(new_group.description) }
  end

  describe '#update' do
    let(:new_description) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_group_path(group)
      fill_in '説明', with: new_description
      click_on 'Update グループ'
    end

    it { expect(page_title).to have_content(group.name) }
    it { expect(current_path).to eq admin_group_path(group) }
    it { expect(page).to have_content(new_description) }
    it { expect(group.reload.description).to eq new_description }
  end
end
