# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  employee_code          :string
#  encrypted_email        :string           not null
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
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  gender                 :integer          default(0), not null
#

class User < ActiveRecord::Base
  include Encryptor
  encrypted_columns :email

  PASSWORD_REGEX = %r|\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d#$%&@'()\/\*\+\.=-]{8,72}+\z|

  has_one :user_profile, dependent: :destroy
  has_one :role, class_name: 'UserRole', dependent: :destroy
  has_many :groups, through: :group_assignments, dependent: :destroy
  has_many :group_assignments
  has_many :monthly_reports
  has_many :monthly_report_comments
  delegate :admin?, to: :role, allow_nil: true
  delegate :operator?, to: :role, allow_nil: true

  validates :name, length: { maximum: 32 }, presence: true
  validates :employee_code, presence: true, uniqueness: true
  validates :encrypted_email, presence: true
  validates :entry_date, presence: true
  validates :beginner_flg, inclusion: { in: [true, false] }
  validates :gender, presence: true
  validate :secure_password

  enum gender: { gender_unknown: 0, male: 1, female: 2 }

  before_validation :initialize_password, on: :create
  after_create :create_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  scope :active, -> { where('deleted_at IS NULL OR deleted_at > ?', Time.current) }

  class << self
    def find_for_database_authentication(warden_conditions)
      find_by(encrypted_email: encrypt(warden_conditions[:email]))
    end

    def report_registrable_to
      Time.current.since(5.days).last_month.to_date
    end
  end

  def report_registrable_months
    months = []
    month = report_registrable_from

    while month <= User.report_registrable_to
      months << month
      month = month.next_month
    end

    months
  end

  def create_profile
    UserProfile.create!(user_id: id)
  end

  def active_for_authentication?
    super && (deleted_at.nil? || deleted_at > Time.current)
  end

  def self.entry_date_select_options
    active_users = User.active
    return [] if active_users.blank?
    first_month = active_users.minimum(:entry_date).beginning_of_month
    last_month = active_users.maximum(:entry_date).beginning_of_month
    ApplicationController.helpers.all_months_select_options(first_month, last_month)
  end

  private

  def report_registrable_from
    entry_date.beginning_of_month
  end

  def secure_password
    return true unless password
    return if password.match(PASSWORD_REGEX)
    errors.add :password, 'は大文字・小文字・数字が1字以上、8文字以上72文字以内で入力してください'
  end

  def initialize_password
    required_chars = ['A'..'Z', 'a'..'z', '0'..'9'].map do |range|
      chars = range.to_a
      chars[rand(chars.size)]
    end

    self.password ||= SecureRandom.base64(8) + required_chars.join
  end
end
