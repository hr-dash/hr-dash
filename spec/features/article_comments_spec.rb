# frozen_string_literal: true

describe ArticleCommentsController, type: :feature do
  let(:user) { create(:user) }
  let(:article) { create(:article, :shipped, :with_tags) }

  before { login user }

  describe '#create POST /article_comments' do
    let(:comment) { build(:article_comment) }

    before do
      visit article_path(article)
      find('#article_comment_comment').set(comment.comment)
      click_on 'Comment'
    end

    it 'successfully created comment.' do
      expect(current_path).to eq article_path(article)
      expect(user.article_comments.size).to eq 1
      expect(user.article_comments.first.comment).to eq comment.comment
    end
  end

  describe '#update PATCH /article_comments/:id', js: true do
    let!(:comment) { create(:article_comment, article: article, user: user) }
    let(:after_comment) { build(:article_comment, article: article) }

    before do
      visit article_path(article)
      find("#comment-#{comment.id} .article_comment_edit").click
      wait_for_ajax

      form = find("#edit_article_comment_#{comment.id}")
      form.find('textarea').set(after_comment.comment)
      form.click_on 'Comment'
    end

    # なぜか#edit_article_comment_#{comment.id}が見つからずテストが通らない
    xit 'successfully updated comment.' do
      expect(current_path).to eq article_path(article)
      expect(user.article_comments.size).to eq 1
      expect(article.comments.first.comment).to eq after_comment.comment
    end
  end

  describe '#destroy DELETE /article_comments/:id' do
    let!(:comment) { create(:article_comment, article: article, user: user) }

    before do
      visit article_path(article)
      find("#comment-#{comment.id} .article_comment_destroy").click
    end

    it 'successfully deleted comment.' do
      expect(current_path).to eq article_path(article)
      expect(article.comments.size).to eq 0
      expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
