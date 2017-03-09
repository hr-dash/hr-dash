# frozen_string_literal: true
describe 'Admin::Dashboard', type: :feature do
  before do
    login(admin: true)
  end

  describe '#index GET /admin' do
    context 'visit dashboard' do
      let(:title) { find('#page_title') }
      before { visit admin_root_path }
      it { expect(title).to have_content('ダッシュボード') }
      it { expect(page).to have_content('最新の月報') }
      it { expect(page).to have_content('最新の未登録タグ') }
    end

    context 'monthly_reports' do
      let!(:report) { create(:monthly_report) }
      let(:target_month) { report.target_month.strftime('%Y年%m月') }
      before { visit admin_root_path }
      it { expect(page).to have_content(report.id) }
      it { expect(page).to have_content(report.user.name) }
      it { expect(page).to have_content(target_month) }
      it { expect(page).to have_content(report.shipped_at.to_s) }
    end

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
