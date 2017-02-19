describe 'Admin::MonthlyReportComment', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:report) { create(:monthly_report, user: user) }
  let!(:comment) { create(:monthly_report_comment, monthly_report: report, user: user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_monthly_report_comments_path }
    it { expect(page_title).to have_content('月報コメント') }
    it { expect(page).to have_content(user.name) }
    it { expect(page).to have_content(comment.comment) }
    it { expect(page).to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_monthly_report_comment_path(comment) }
    it { expect(page).to have_content(comment.comment) }
  end

  describe '#update' do
    let(:new_comment) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_monthly_report_comment_path(comment)
      fill_in 'コメント', with: new_comment
      click_on '月報コメントを更新'
    end

    it { expect(page).to have_content(new_comment) }
    it { expect(current_path).to eq admin_monthly_report_comment_path(comment) }
    it { expect(comment.reload.comment).to eq new_comment }
  end

  describe '#destroy', js: true do
    before do
      visit admin_monthly_report_comments_path
      accept_confirm do
        find("#monthly_report_comment_#{comment.id}").find('.delete_link').click
      end
    end

    it { expect(current_path).to eq admin_monthly_report_comments_path }
    it { expect(page).not_to have_content(comment.comment) }
    it { expect { comment.reload }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
