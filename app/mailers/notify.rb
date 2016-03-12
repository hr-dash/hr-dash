class Notify < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notify.monthly_report_registration.subject
  #
  def monthly_report_registration
    @greeting = "Hi"

    mail to: Settings.mailer[:mail_address]
  end
end
