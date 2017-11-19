# frozen_string_literal: true
describe 'Admin::ArticleComment', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let!(:comment) { create(:article_comment, article: article, user: user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_article_comments_path }
    it 'should open index page.' do
      expect(page_title).to have_content('ノートコメント')
      expect(page).to have_content(user.name)
      expect(page).to have_content(comment.comment)
      expect(page).to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_article_comment_path(comment) }
    it { expect(page).to have_content(comment.comment) }
  end

  describe '#update' do
    let(:new_comment) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_article_comment_path(comment)
      fill_in 'コメント', with: new_comment
      click_on 'ノートコメントを更新'
    end

    it 'should update the article comment.' do
      expect(page).to have_content(new_comment)
      expect(current_path).to eq admin_article_comment_path(comment)
      expect(comment.reload.comment).to eq new_comment
    end
  end

  describe '#destroy', js: true do
    before do
      visit admin_article_comments_path
      accept_confirm do
        find("#article_comment_#{comment.id}").find('.delete_link').click
      end
    end

    it 'should delete the article comment.' do
      expect(current_path).to eq admin_article_comments_path
      expect(page).not_to have_content(comment.comment)
      expect { comment.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
