module Mailer
  class Error < ApplicationMailer
    def create(exception, user, request)
      @exception = exception
      @user = user
      @request = request

      @title = "#{exception.class} が発生しました"
      mail(to: ENV['SYSTEM_MAIL'], subject: @title)
    end
  end
end
