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
  validates :project_summary, length: { maximum: 5000 }
  validates :business_content, length: { maximum: 5000 }
  validates :looking_back, length: { maximum: 5000 }
  validates :next_month_goals, length: { maximum: 5000 }
  validate :target_beginning_of_month?
  validate :target_month_registrable_term
  validate :uniq_by_user_and_target_month, on: :create
  with_options if: :shipped? do
    validates :project_summary, presence: true
    validates :business_content, presence: true
    validates :looking_back, presence: true
    validates :next_month_goals, presence: true
    validates :monthly_report_tags, presence: true
    validates :monthly_working_processes, presence: true
  end

  validates_associated :monthly_report_tags

  scope :year, ->(year) { where(target_month: (Time.zone.local(year))..(Time.zone.local(year).end_of_year)) }
  scope :released, -> { where.not(shipped_at: nil) }

  enum status: { wip: 0, shipped: 1 }

  before_save :log_shipped_at

  def self.already_registered?(user)
    last_month = user.report_registrable_months.last.strftime('%a, %d %b %Y')
    find_by(user: user, target_month: last_month).present?
  end

  def registrable_term?
    return false unless user
    user.report_registrable_months.include? target_month
  end

  def prev_month
    return unless target_month
    self.class.find_by(user: user, target_month: target_month.prev_month)
  end

  def next_month
    return unless target_month
    self.class.find_by(user: user, target_month: target_month.next_month)
  end

  def this_month_goals
    prev_month.try!(:next_month_goals)
  end

  def set_prev_monthly_report!
    fail ActiveRecord::RecordNotFound unless prev_month
    contents = %w(project_summary business_content looking_back next_month_goals)
    assign_attributes(prev_month
                      .attributes
                      .select { |key, _| contents.include? key }
                      .merge('tags' => prev_month.tags,
                             'monthly_working_processes' => prev_month.monthly_working_processes))
    self
  end

  private

  def target_month_registrable_term
    return if user.blank?
    return if target_month.blank?
    return if registrable_term?
    errors.add :target_month, ' must included by user.report_registrable_months'
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
