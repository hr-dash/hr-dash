# frozen_string_literal: true

describe 'Admin::Article', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_articles_path }
    it 'should open index page.' do
      expect(page_title).to have_content('ノート')
      expect(page).to have_content(user.name)
      expect(page).to have_content(article.shipped_at)
    end
  end

  describe '#show' do
    before { visit admin_article_path(article) }
    it { expect(page).to have_content(article.body) }
  end

  describe '#update' do
    let(:new_title) { Faker::Lorem.word }
    before do
      visit edit_admin_article_path(article)
      fill_in 'タイトル', with: new_title
      click_on 'ノートを更新'
    end

    it 'should update the article.' do
      expect(page).to have_content(new_title)
      expect(current_path).to eq admin_article_path(article)
      expect(article.reload.title).to eq new_title
    end
  end

  describe '#dastroy', js: true do
    before do
      visit admin_articles_path
      accept_confirm do
        find("#article_#{article.id}").find('.delete_link').click
      end
    end

    it 'should delete the article.' do
      expect(current_path).to eq admin_articles_path
      expect(page).not_to have_content(article.title)
      expect { article.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
