module Mailer
  class Inquiry < ApplicationMailer
    def create(inquiry)
      @inquiry = inquiry
      user = inquiry.user
      @title = "#{user.name}（USER_ID: #{user.id}）さんからお問い合わせが届きました"

      mail(to: ENV['SYSTEM_MAIL'], subject: @title)
    end
  end
end