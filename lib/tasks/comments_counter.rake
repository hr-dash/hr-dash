# frozen_string_literal: true

namespace :comments_counter do
  desc 'Calculate monthly_report_comments count'
  task calculate: :environment do
    MonthlyReport.all.each do |report|
      report.update(comments_count: report.comments.count)
    end
  end
end
