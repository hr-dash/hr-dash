# Preview all emails at http://localhost:3000/rails/mailers/notify
class NotifyPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/notify/monthly_report_registration
  def monthly_report_registration
    Notify.monthly_report_registration
  end
end
