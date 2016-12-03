module Mailer
  class EndOfMonth < ApplicationMailer
    def notice
      @domain = ENV['RAILS_ENV'] == 'production' ? ENV['DOMAIN'] : 'localhost:3000'
      title = '[お知らせ]今月の月報が登録可能になりました。'
      mail(to: ENV['MAILING_LIST_TO_ALL_USER'], subject: title)
    end
  end
end
