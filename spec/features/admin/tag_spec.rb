describe 'Admin::Tag', type: :feature do
  before { login(admin: true) }
  let!(:tag) { create(:tag) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_tags_path }
    it { expect(page_title).to have_content('タグ') }
    it { expect(page).to have_content(tag.name) }
    it { expect(page).to have_content('作成する') }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_tag_path(tag) }
    it { expect(page_title).to have_content(tag.name) }
    it { expect(page).to have_content(tag.name) }
  end

  describe '#create' do
    let(:new_tag) { build(:tag) }
    before do
      visit new_admin_tag_path
      fill_in '名前', with: new_tag.name
      select 'fixed', from: 'tag_status'
      click_on 'Create タグ'
    end

    it { expect(page_title).to have_content(new_tag.name) }
    it { expect(page).to have_content('fixed') }
  end

  describe '#update' do
    let(:new_name) { Faker::Lorem.word }
    before do
      visit edit_admin_tag_path(tag)
      fill_in '名前', with: new_name
      click_on 'Update タグ'
    end

    it { expect(page_title).to have_content(new_name) }
    it { expect(current_path).to eq admin_tag_path(tag) }
    it { expect(page).to have_content(new_name) }
    it { expect(tag.reload.name).to eq new_name }
  end
end
