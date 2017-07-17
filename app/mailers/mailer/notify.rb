# frozen_string_literal: true
module Mailer
  class Notify < ApplicationMailer
    def monthly_report_registration(user_id, monthly_report_id)
      @report = MonthlyReport.find(monthly_report_id)
      @user = User.find(user_id)
      return unless @user.groups.present?

      @title = "#{@user.name}が#{@report.target_month.strftime('%Y年%m月')}の月報を登録しました"
      mail(to: @user.groups.map(&:email), subject: mail_subject(@title))
    end

    def report_registrable_to
      title = '[お知らせ]今月の月報が登録可能になりました。'
      mail(to: ENV['MAILING_LIST_TO_ALL_USER'], subject: mail_subject(title))
    end

    def monthly_report_commented(comment_id)
      @comment = MonthlyReportComment.find(comment_id)
      target_users = monthly_report_commented_targets(@comment)
      return if target_users.blank?

      report = @comment.monthly_report
      report_name = "#{report.user.name}さんの月報（#{report.target_month.strftime('%Y年%m月')}）"
      @title = "#{@comment.user.name}さんが#{report_name}にコメントしました"

      mail(to: target_users.map(&:email), subject: mail_subject(@title))
    end

    def daily_report_registration(user_id, daily_report_id)
      @report = DailyReport.find(daily_report_id)
      @user = User.find(user_id)
      return unless @user.groups.present?

      @title = "#{@user.name}が#{@report.target_date.strftime('%Y年%m月%d日')}の日報を登録しました"
      mail(to: @user.groups.map(&:email), subject: mail_subject(@title))
    end

    def daily_report_commented(comment_id)
      @comment = DailyReportComment.find(comment_id)
      target_users = daily_report_commented_targets(@comment)
      return if target_users.blank?

      report = @comment.daily_report
      report_name = "#{report.user.name}さんの日報（#{report.target_date.strftime('%Y年%m月d日')}）"
      @title = "#{@comment.user.name}さんが#{report_name}にコメントしました"

      mail(to: target_users.map(&:email), subject: mail_subject(@title))
    end

    private

    def monthly_report_commented_targets(comment)
      comment.monthly_report.related_users - [comment.user]
    end

    def daily_report_commented_targets(comment)
      comment.daily_report.related_users - [comment.user]
    end
  end
end
