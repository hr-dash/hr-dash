# frozen_string_literal: true
# == Schema Information
#
# Table name: daily_reports
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  target_date      :date             not null
#  shipped_at       :datetime
#  business_content :text
#  looking_back     :text
#  comments_count   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class DailyReport < ApplicationRecord
  belongs_to :user
  has_many :comments, class_name: 'DailyReportComment', dependent: :delete_all

  validates :user, presence: true
  validates :target_date, presence: true
  validates :business_content, length: { maximum: 5000 }
  validates :looking_back, length: { maximum: 5000 }
  validate :target_date_registrable_term
  validate :uniq_by_user_and_target_date, on: :create
  with_options if: :shipped? do
    validates :business_content, presence: true
    validates :looking_back, presence: true
  end

  scope :released, -> { where.not(shipped_at: nil) }
  scope :latest, -> { where(target_date: Date.today) }

  def self.year_month(year, month)
    all.where(target_date: (Time.zone.local(year, month))..(Time.zone.local(year, month).end_of_month))
  end

  def self.of_latest_day_registered_by(user)
    user.daily_reports.find_by(target_date: Date.today)
  end

  def registrable_term?
    return false unless user
    user.report_registrable_dates.include? target_date
  end

  def prev_date
    return unless target_date
    DailyReport.find_by(user: user, target_date: target_date - 1.day)
  end

  def next_date
    return unless target_date
    DailyReport.find_by(user: user, target_date: target_date + 1.day)
  end

  def set_prev_daily_report
    raise ActiveRecord::RecordNotFound unless prev_date
    contents = %w(business_content looking_back)
    assign_attributes(prev_date
                      .attributes
                      .select { |key, _| contents.include? key })
    self
  end

  def shipped?
    shipped_at.present?
  end

  def related_users
    users = [user]
    users += comments.map(&:user)
    users.uniq
  end

  def browseable?(other_user)
    shipped? || user == other_user
  end

  def self.year_select_options
    return [] if DailyReport.released.blank?
    min, max = DailyReport.released.pluck(:target_date).map(&:year).minmax
    [*(min..max)].map { |y| [y, y] }
  end

  def self.month_select_options
    DailyReport.released.present? ? [*(1..12)].map { |m| [m, m] } : []
  end

  def self.day_select_options
    DailyReport.released.present? ? [*(1..31)].map { |d| [d, d] } : []
  end

  private

  def target_date_registrable_term
    return if user.blank?
    return if target_date.blank?
    return if registrable_term?
    errors.add :target_date, ' must included by user.report_registrable_dates'
  end

  def uniq_by_user_and_target_date
    return if target_date.blank? || user.blank?
    return unless self.class.find_by(user: user, target_date: target_date)
    errors.add :target_date, 'report already registered'
  end
end
