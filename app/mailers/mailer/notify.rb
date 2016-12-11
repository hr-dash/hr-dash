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
      return unless @user.groups

      @title = "#{@user.name}が#{@report.target_month.strftime('%Y年%m月')}の月報を登録しました"
      mail(to: @user.groups.map(&:email), subject: @title)
    end

    def report_registrable_to
      @domain = ENV['MAILER_DEFAULT_HOST']
      title = '[お知らせ]今月の月報が登録可能になりました。'
      mail(to: ENV['MAILING_LIST_TO_ALL_USER'], subject: title)
    end
  end
end
