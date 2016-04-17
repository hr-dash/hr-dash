class HelpText < ActiveRecord::Base
  validates :category, presence: true
  validates :help_type, presence: true
  validates :target, presence: true
  validates :body, presence: true
end
