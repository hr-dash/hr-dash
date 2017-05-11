# frozen_string_literal: true
# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  email       :string           not null
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Group < ApplicationRecord
  has_many :users, through: :group_assignments, dependent: :destroy
  has_many :group_assignments

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@]+@[^@]+\z/ }

  scope :active, -> { where('deleted_at IS NULL OR deleted_at > ?', Time.current) }
end
