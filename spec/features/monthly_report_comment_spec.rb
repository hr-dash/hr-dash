describe MonthlyReportCommentsController, type: :feature do
  let(:user) { create(:user) }
  let(:report) { create(:monthly_report, :shipped, :with_tags) }

  before { login user }

  describe '#create POST /monthly_report_comments' do
    let(:comment) { build(:monthly_report_comment) }

    before do
      visit monthly_report_path(report)
      find('#monthly_report_comment_comment').set(comment.comment)
      click_on 'Comment'
    end

    it { expect(current_path).to eq monthly_report_path(report) }
    it { expect(user.monthly_report_comments.size).to eq 1 }
    it { expect(user.monthly_report_comments.first.comment).to eq comment.comment }
  end

  describe '#update PATCH /monthly_report_comments/:id', js: true do
    let!(:comment) { create(:monthly_report_comment, monthly_report: report, user: user) }
    let(:after_comment) { build(:monthly_report_comment, monthly_report: report) }

    before do
      visit monthly_report_path(report)
      find("#comment-#{comment.id} .monthly_report_comment_edit").click
      wait_for_ajax

      form = find("#edit_monthly_report_comment_#{comment.id}")
      form.find('textarea').set(after_comment.comment)
      form.click_on 'Comment'
    end

    it { expect(current_path).to eq monthly_report_path(report) }
    it { expect(user.monthly_report_comments.size).to eq 1 }
    it { expect(report.comments.first.comment).to eq after_comment.comment }
  end

  describe '#destroy DELETE /monthly_report_comments/:id', js: true do
    let!(:comment) { create(:monthly_report_comment, monthly_report: report, user: user) }

    before do
      visit monthly_report_path(report)
      accept_confirm do
        find("#comment-#{comment.id} .monthly_report_comment_destroy").click
      end
    end

    it { expect(current_path).to eq monthly_report_path(report) }
    it { expect(report.comments.size).to eq 0 }
    it { expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound }
  end
end
