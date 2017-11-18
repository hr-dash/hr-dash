# frozen_string_literal: true

# == Schema Information
#
# Table name: group_assignments
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupAssignment < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :group, presence: true
  validates :user, presence: true
end
