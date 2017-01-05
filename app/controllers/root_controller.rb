class RootController < ApplicationController
  def index
    references = [{ user: :groups }, :monthly_working_process, { monthly_report_tags: :tag }]
    @monthly_reports = MonthlyReport.includes(references).released.order('shipped_at desc').first(5)
    @announcements = Announcement.published.first(5)
  end
end
