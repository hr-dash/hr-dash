# frozen_string_literal: true

# == Schema Information
#
# Table name: announcements
#
#  id             :integer          not null, primary key
#  title          :string           not null
#  body           :text             not null
#  published_date :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Announcement < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :published_date, presence: true

  def self.published
    where('published_date <= ?', Time.current.to_date).order('published_date desc')
  end
end
