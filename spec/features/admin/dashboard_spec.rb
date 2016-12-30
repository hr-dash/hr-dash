describe 'Admin::Dashboard', type: :feature do
  before do
    login(admin: true)
  end

  describe '#index GET /admin' do
    before { visit admin_root_path }
    let(:title) { find('#page_title') }
    it { expect(title).to have_content('ダッシュボード') }
    it { expect(page).to have_content('未登録タグ') }

    context 'unfixed tag' do
      let!(:tag) { create(:tag, :unfixed) }
      before { visit admin_root_path }
      it { expect(page).to have_content(tag.name) }
    end

    context 'fixed tag' do
      let!(:tag) { create(:tag, :fixed) }
      before { visit admin_root_path }
      it { expect(page).not_to have_content(tag.name) }
      it { expect(page).to have_content('未登録のタグはありません') }
    end
  end
end
