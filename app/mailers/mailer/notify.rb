module Mailer
  class Notify < ApplicationMailer
    default parts_order: ['text/plain', 'text/enriched', 'text/html']
    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.notify.monthly_report_registration.subject
    #
    def monthly_report_registration(user_id, monthly_report_id)
      @report = MonthlyReport.find(monthly_report_id)
      @user = User.find(user_id)
      return unless @user.group

      @title = "#{@user.name}が#{@report.target_month.strftime('%Y年%m月')}の月報を登録しました"
      mail(to: @user.group.email, subject: @title)
    end
  end
end
