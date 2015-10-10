# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  validates :id, numericality: { only_integer: true },
                 uniqueness: true, presence: true
  validates :name, length: { maximum: 32 }, presence: true
end
