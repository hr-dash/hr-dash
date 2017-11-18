# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  status     :integer          default(0), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  VALID_NAME_REGEX = /\A(?:[a-zA-Z0-9_\.\+\#\'-]|\p{Blank}|\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/

  validates :status, presence: true
  validates :name, length: { maximum: 32 }, presence: true, format: { with: VALID_NAME_REGEX }

  enum status: { unfixed: 0, fixed: 1, ignored: 2 }

  def self.find_or_initialize_by_name_ignore_case(name)
    Tag.where('LOWER(name) = LOWER(?)', name).first || Tag.new(name: name)
  end
end
