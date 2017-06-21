# frozen_string_literal: true
describe 'Admin::Tag', type: :feature do
  before { login(admin: true) }
  let!(:tag) { create(:tag) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_tags_path }
    it 'should open the index page' do
      expect(page_title).to have_content('タグ')
      expect(page).to have_content(tag.name)
      expect(page).to have_content('作成する')
      expect(page).not_to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_tag_path(tag) }
    it 'should open the show page' do
      expect(page_title).to have_content(tag.name)
      expect(page).to have_content(tag.name)
    end
  end

  describe '#create' do
    let(:new_tag) { build(:tag) }
    before do
      visit new_admin_tag_path
      fill_in '名前', with: new_tag.name
      select 'fixed', from: 'tag_status'
      click_on 'タグを作成'
    end

    it 'should create the new tag' do
      expect(page_title).to have_content(new_tag.name)
      expect(page).to have_content('fixed')
    end
  end

  describe '#update' do
    let(:new_name) { Faker::Lorem.word }
    before do
      visit edit_admin_tag_path(tag)
      fill_in '名前', with: new_name
      click_on 'タグを更新'
    end

    it 'should update the tag' do
      expect(page_title).to have_content(new_name)
      expect(current_path).to eq admin_tag_path(tag)
      expect(page).to have_content(new_name)
      expect(tag.reload.name).to eq new_name
    end
  end

  describe 'batch_action', js: true do
    let!(:tag) { create(:tag, :unfixed) }

    before do
      visit admin_tags_path
      check "batch_action_item_#{tag.id}"
      click_on '一括操作'
    end

    context 'fixedにする' do
      before { click_on '選択した行をfixedにする' }

      it 'should update tag status to fixed' do
        expect(page).to have_content('1個のタグをfixedにしました')
        expect(tag.reload).to be_fixed
      end
    end

    context 'ignoredにする' do
      before { click_on '選択した行をignoredにする' }

      it 'should update tag status to ignored' do
        expect(page).to have_content('1個のタグをignoredにしました')
        expect(tag.reload).to be_ignored
      end
    end
  end
end
