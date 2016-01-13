# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  status     :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  validates :status, presence: true
  validates :name, length: { maximum: 32 }, presence: true

  enum status: { unfixed: 0, fixed: 1 }
end
