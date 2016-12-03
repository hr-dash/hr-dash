namespace :end_of_month_notice do
  desc 'Send email notification if user can register monthry report.'
  task execute: :environment do
    Mailer::EndOfMonth.notice.deliver_now
  end
end
