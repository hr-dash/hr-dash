module Mailer
  class Notify < ApplicationMailer
    def monthly_report_registration(user_id, monthly_report_id)
      @report = MonthlyReport.find(monthly_report_id)
      @user = User.find(user_id)
      return unless @user.groups

      @title = "#{@user.name}が#{@report.target_month.strftime('%Y年%m月')}の月報を登録しました"
      mail(to: @user.groups.map(&:email), subject: @title)
    end
  end
end
