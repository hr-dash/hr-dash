class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer[:from]
end
