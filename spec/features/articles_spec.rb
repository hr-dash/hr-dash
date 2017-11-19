# frozen_string_literal: true
describe ArticlesController, type: :feature do
  let(:user) { create(:user) }
  before { login user }

  describe '#index GET /articles' do
    describe 'sort by shipped_at desc' do
      let!(:today) { create(:article, :with_tags, shipped_at: Date.today) }
      let!(:yesterday) { create(:article, :with_tags, shipped_at: Date.yesterday) }
      let(:first_report) { find('#article_index').first('a') }

      before { visit articles_path }
      it { expect(first_report[:href]).to eq article_path(today) }
    end
  end

  describe '#user GET /articles/users/:user_id' do
    let!(:today) { create(:article, :with_tags, user: user, shipped_at: Date.today) }
    let!(:yesterday) { create(:article, :with_tags, user: user, shipped_at: Date.yesterday) }
    let(:first_report) { find('#article_index').first('a') }
    let(:title) { find('.page-header') }
    let(:btn) { find('.btn.btn-info').first('a') }

    before { visit user_articles_path(user) }

    it { expect(first_report[:href]).to eq article_path(today) }
    it { expect(btn).to have_content '下書き中のノート一覧へ' }
    it { expect(title).to have_content "#{user.name}さんのノート一覧" }
  end

  describe '#drafts GET /articles/users/:user_id/drafts' do
    let!(:today) { create(:article, :with_tags, user: user) }
    let!(:yesterday) { create(:article, :with_tags, user: user) }
    let(:first_report) { find('#article_index').first('a') }
    let(:title) { find('.page-header') }
    let(:btn) { find('.article-user').first('div') }

    before { visit drafts_articles_path(user) }

    it { expect(first_report[:href]).to eq article_path(yesterday) }
    it { expect(btn).to have_content '公開済みのノート一覧へ' }
    it { expect(title).to have_content '下書き中のノート一覧' }
  end

  describe '#create POST /articles', js: true do
    before { visit new_article_path }

    context 'valid' do
      let(:status) { find('.article-status').text }

      context 'registered as wip' do
        before do
          fill_in 'タイトル', with: 'すごいH本を読んでみた'
          find('#article_tags_input').set('Haskell')
          click_button 'Save as WIP （下書き保存）'
        end

        it { expect(page).not_to have_content '本文を入力してください' }
        it { expect(status).to eq '下書き' }
      end

      context 'registered as shipped' do
        before do
          fill_in 'タイトル', with: 'すごいH本を読んでみた'
          find('#article_tags_input').set('Haskell')
          fill_in '本文', with: 'Haskellすごーい、たのしー！'
          click_button 'Ship（保存して公開）'
        end

        it { expect(page).not_to have_content '本文を入力してください' }
        it { expect(status).to eq '公開済' }
      end
    end

    context 'in valid' do
      before { click_button 'Ship（保存して公開）' }

      it { expect(page).to have_content 'タイトルを入力してください' }
      it { expect(page).to have_content '本文を入力してください' }
      it { expect(page).to have_content 'タグを入力してください' }
    end
  end

  describe '#update PATCH /article/:id', js: true do
    let!(:article) { create(:shipped_article, user: user) }
    let(:title) { find('.page-header') }
    let(:tags) { find('.tags') }
    let(:body) { find('.article-show') }

    before do
      visit edit_article_path(article)
      fill_in 'タイトル', with: 'すごいH本を読んでみた'
      find('#article_tags_input').set('Haskell')
      fill_in '本文', with: 'Haskellすごーい、たのしー！'
      click_button 'Update （ノートを更新）'
    end

    it { expect(title).to have_content 'すごいH本を読んでみた' }
    it { expect(tags).to have_content 'Haskell' }
    it { expect(body).to have_content 'Haskellすごーい、たのしー！' }
  end

  describe '#destroy DELETE /article/:id', js: true do
    let!(:article) { create(:shipped_article, user: user) }
    before do
      visit article_path(article)
      find('a.glyphicon-remove').click
      click_on 'はい'
    end

    it { expect(page).to have_content 'ノートを削除しました' }
    it { expect(current_path).to eq '/articles' }
  end

  describe '#show GET /artices/:id' do
    before { visit article_path(article) }

    context 'show own article' do
      subject { find('.article-status').text }

      context 'is shipped' do
        let!(:article) { create(:shipped_article, user: user) }

        it { is_expected.to eq '公開済' }
      end

      context 'is wip' do
        let!(:article) { create(:article, :wip, user: user) }

        it { is_expected.to eq '下書き' }
      end
    end

    context 'show other user article' do
      let(:other_user) { create(:user) }

      context 'is shipped' do
        let!(:article) { create(:shipped_article, user: other_user) }

        it { expect(page).not_to have_selector '.article-status' }
      end

      context 'is wip' do
        let!(:article) { create(:article, :wip, user: other_user) }
        let(:body) { find('.error-body') }

        it { expect(body).to have_content '403' }
      end
    end
  end
end
