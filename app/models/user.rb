# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string
#  group_id      :integer
#  employee_code :integer
#  email         :string
#  entry_date    :date
#  beginner_flg  :boolean
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
  belongs_to :group

  validates :name, length: { maximum: 32 }, presence: true
  validates :employee_code, presence: true, uniqueness: true
  validates :email, length: { maximum: 255 }, email: true, presence: true
  validates :entry_date, presence: true
  validates :beginner_flg, inclusion: { in: [true, false] }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
