class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer[:mail_address]
end
