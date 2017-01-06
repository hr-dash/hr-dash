class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  def mail_subject(title)
    "【Dash】#{title}"
  end
end
