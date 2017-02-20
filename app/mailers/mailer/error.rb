# frozen_string_literal: true
module Mailer
  class Error < ApplicationMailer
    def create(exception, user, request)
      @exception = exception
      @user = user
      @request = request

      @title = "#{exception.class} が発生しました"
      mail(to: ENV['SYSTEM_MAIL'], subject: mail_subject(@title))
    end
  end
end
