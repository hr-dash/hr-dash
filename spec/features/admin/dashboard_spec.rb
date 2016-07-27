describe 'Admin::Dashboard', type: :feature do
  before do
    login(admin: true)
  end

  describe '#index GET /admin' do
    before { visit admin_root_path }
    let(:title) { find('#page_title') }
    it { expect(title).to have_content('ダッシュボード') }
  end
end
