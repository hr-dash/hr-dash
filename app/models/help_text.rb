class HelpText < ActiveRecord::Base
  validates :category, presence: true
  validates :help_type, presence: true
  validates :target, presence: true
  validates :body, presence: true

  scope :placeholder, -> { where(help_type: :placeholder) }

  def self.placeholders(category)
    where(category: category)
      .placeholder
      .pluck(:target, :body)
      .to_h
      .symbolize_keys
  end
end
