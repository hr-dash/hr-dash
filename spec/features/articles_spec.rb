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
      click_button 'Update （記事を更新）'
    end

    it { expect(title).to have_content 'すごいH本を読んでみた' }
    it { expect(tags).to have_content 'Haskell' }
    it { expect(body).to have_content 'Haskellすごーい、たのしー！' }
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
