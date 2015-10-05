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
end
