# == Schema Information
#
# Table name: monthly_reports
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  target_month     :date             not null
#  status           :integer          not null
#  shipped_at       :datetime
#  project_summary  :text
#  business_content :text
#  looking_back     :text
#  next_month_goals :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class MonthlyReport < ActiveRecord::Base
  belongs_to :user
  has_many :comments, class_name: 'MonthlyReportComment', dependent: :destroy
  has_many :monthly_report_tags, dependent: :destroy
  has_many :tags, through: :monthly_report_tags
  has_many :monthly_working_processes, dependent: :destroy

  validates :user, presence: true
  validates :target_month, presence: true
  validate :target_beginning_of_month?
  validate :target_month_registrable_term
  validate :uniq_by_user_and_target_month, on: :create

  scope :year, ->(year) { where(target_month: (Time.zone.local(year))..(Time.zone.local(year).end_of_year)) }
  scope :released, -> { where.not(shipped_at: nil) }

  REGISTRABLE_TERM_FROM = Time.local(2000, 1, 1)

  enum status: { wip: 0, shipped: 1 }

  before_save :log_shipped_at

  def registrable_term?
    registrable_term.cover? target_month
  end

  def registrable_term
    registrable_term_from..registrable_term_to
  end

  def prev_month
    self.class.find_by(user: user, target_month: target_month.prev_month)
  end

  def next_month
    self.class.find_by(user: user, target_month: target_month.next_month)
  end

  private

  def registrable_term_from
    REGISTRABLE_TERM_FROM
  end

  def registrable_term_to
    Time.current.last_month.since(5.days)
  end

  def target_month_registrable_term
    return if target_month.blank?
    return if registrable_term?
    errors.add :target_month, " must be #{registrable_term}"
  end

  def target_beginning_of_month?
    return if target_month.blank?
    return if target_month == target_month.beginning_of_month
    errors.add :target_month, 'invalid target month'
  end

  def uniq_by_user_and_target_month
    return if target_month.blank? || user.blank?
    return unless self.class.find_by(user: user, target_month: target_month)
    errors.add :target_month, 'report already registered'
  end

  def log_shipped_at
    return if status == 'wip'
    self.shipped_at ||= Time.current
  end
end
