# frozen_string_literal: true
describe 'Admin::ArticleTag', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:tag) { article_tag.tag }
  let!(:article_tag) { create(:article_tag, article: article) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_article_tags_path }

    it 'should open the index page.' do
      expect(page_title).to have_content('ノートタグ')
      expect(page).to have_content(tag.name)
      expect(page).to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_article_tag_path(article_tag) }
    it { expect(page).to have_content(tag.name) }
  end

  describe '#update' do
    let!(:new_tag) { create(:tag) }
    before do
      visit edit_admin_article_tag_path(article_tag)
      select new_tag.name, from: 'article_tag_tag_id'
      click_on 'ノートタグを更新'
    end

    it 'should update the article tag.' do
      expect(page).to have_content(new_tag.name)
      expect(current_path).to eq admin_article_tag_path(article_tag)
      expect(article_tag.reload.tag).to eq new_tag
    end
  end

  describe '#destroy', js: true do
    before do
      visit admin_article_tags_path
      accept_confirm do
        find("#article_tag_#{article_tag.id}").find('.delete_link').click
      end
    end

    it 'should delete the article tag.' do
      expect(current_path).to eq admin_article_tags_path
      expect(page).not_to have_content(tag.name)
      expect { article_tag.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
