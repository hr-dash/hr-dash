# frozen_string_literal: true

namespace :notifer do
  desc 'Send email notification if user can register monthly report.'
  task report_registrable: :environment do
    beginning_of_month = Time.current.beginning_of_month.strftime('%F')
    registrable_date = User.report_registrable_to.strftime('%F')
    if beginning_of_month == registrable_date
      Mailer::Notify.report_registrable_to.deliver_now
    end
  end
end
