# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  group_id               :integer
#  employee_code          :string
#  email                  :string
#  entry_date             :date
#  beginner_flg           :boolean
#  deleted_at             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  gender                 :integer          default(0), not null
#

class User < ActiveRecord::Base
  has_one :user_profile, dependent: :destroy
  has_one :role, class_name: 'UserRole', dependent: :destroy
  belongs_to :group
  has_many :monthly_reports
  has_many :monthly_report_comments
  delegate :admin?, to: :role, allow_nil: true

  validates :name, length: { maximum: 32 }, presence: true
  validates :employee_code, presence: true, uniqueness: true
  validates :entry_date, presence: true
  validates :beginner_flg, inclusion: { in: [true, false] }
  validates :gender, presence: true

  enum gender: { gender_unknown: 0, male: 1, female: 2 }

  before_validation :initialize_password, on: :create
  after_create :create_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def report_registrable_months
    months = []
    month = report_registrable_from

    while month <= report_registrable_to
      months << month
      month = month.next_month
    end

    months
  end

  def report_registrable_to
    Time.current.since(5.days).last_month.to_date
  end

  def create_profile
    UserProfile.create!(user_id: id)
  end

  private

  def report_registrable_from
    entry_date.beginning_of_month
  end

  def initialize_password
    self.password ||= SecureRandom.base64(8)
  end
end
