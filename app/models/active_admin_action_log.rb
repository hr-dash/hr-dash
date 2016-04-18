# == Schema Information
#
# Table name: active_admin_action_logs
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  resource_id   :integer
#  resource_type :string
#  path          :string
#  action        :string
#  changes_log   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ActiveAdminActionLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource, polymorphic: true

  validates :user, presence: true
  validates :resource, presence: true
  validates :path, presence: true
  validates :action, presence: true
end
