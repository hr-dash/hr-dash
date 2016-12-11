namespace :report_registrable_to do
  desc 'Send email notification if user can register monthly report.'
  task execute: :environment do
    if Time.current.beginning_of_month == User.report_registrable_to
      Mailer::Notice.report_registrable_to.deliver_now
    end
  end
end
