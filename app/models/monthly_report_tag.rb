# frozen_string_literal: true

# == Schema Information
#
# Table name: monthly_report_tags
#
#  id                :integer          not null, primary key
#  monthly_report_id :integer          not null
#  tag_id            :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class MonthlyReportTag < ApplicationRecord
  belongs_to :monthly_report
  belongs_to :tag
  delegate :name, to: :tag

  validates :tag_id, numericality: { only_integer: true }, presence: true
end
