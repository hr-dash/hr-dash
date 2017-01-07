module Mailer
  class Notify < ApplicationMailer
    def monthly_report_registration(user_id, monthly_report_id)
      @report = MonthlyReport.find(monthly_report_id)
      @user = User.find(user_id)
      return unless @user.groups.present?

      @title = "#{@user.name}が#{@report.target_month.strftime('%Y年%m月')}の月報を登録しました"
      mail(to: @user.groups.map(&:email), subject: mail_subject(@title))
    end

    def monthly_report_commented(comment_id)
      @comment = MonthlyReportComment.find(comment_id)
      report = @comment.monthly_report

      target_users = report.related_users - [@comment.user]
      return if target_users.blank?

      report_name = "#{report.user.name}さんの月報（#{report.target_month.strftime('%Y年%m月')}）"
      @title = "#{@comment.user.name}さんが#{report_name}にコメントしました"

      mail(to: target_users.map(&:email), subject: mail_subject(@title))
    end
  end
end
