# frozen_string_literal: true
# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  status     :integer          default("unfixed"), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  VALID_NAME_REGEX = /\A(?:[a-zA-Z0-9_\.\+\#\'-]|\p{Blank}|\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/

  validates :status, presence: true
  validates :name, length: { maximum: 32 }, presence: true, format: { with: VALID_NAME_REGEX }

  enum status: { unfixed: 0, fixed: 1, ignored: 2 }

  class << self
    def find_or_initialize_by_name_ignore_case(name)
      Tag.where('LOWER(name) = LOWER(?)', name).first || Tag.new(name: name)
    end

    def import_tags_by_name(tag_names)
      return [] if tag_names.blank?
      tags = tag_names.map { |name| find_or_initialize_by_name_ignore_case(name) }
      saved, unsaved = tags.partition { |tag| tag[:id].present? }
      import(unsaved, syncronize: unsaved)
      saved + unsaved
    end
  end
end
