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

  after_create :create_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def create_profile
    UserProfile.create!(user_id: id)
  end
end
