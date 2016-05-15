# == Schema Information
#
# Table name: help_texts
#
#  id         :integer          not null, primary key
#  category   :string
#  help_type  :string
#  target     :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HelpText < ActiveRecord::Base
  validates :category, presence: true
  validates :help_type, presence: true
  validates :target, presence: true
  validates :body, presence: true

  scope :placeholder, -> { where(help_type: :placeholder) }
  scope :hint, -> { where(help_type: :hint) }

  def self.placeholders(category)
    where(category: category)
      .placeholder
      .pluck(:target, :body)
      .to_h
      .symbolize_keys
  end

  def self.hints(category)
    where(category: category)
      .hint
      .pluck(:target, :body)
      .to_h
      .symbolize_keys
  end
end
