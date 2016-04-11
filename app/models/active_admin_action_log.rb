class ActiveAdminActionLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource, polymorphic: true

  validates :user, presence: true
  validates :resource, presence: true
  validates :path, presence: true
  validates :action, presence: true
end
