module MonthlyReportsHelper
  def status_is_shipped?(report)
    report.status == 'shipped'
  end
end
