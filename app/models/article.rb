# frozen_string_literal: true
# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  body       :text
#  shipped_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, class_name: 'ArticleComment', dependent: :delete_all
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  validates :user, presence: true
  validates :title, length: { maximum: 100 }
  validates :body, length: { maximum: 5000 }

  with_options if: :shipped? do
    validates :title, presence: true
    validates :body, presence: true
    validates :article_tags, presence: true
  end

  scope :released, -> { where.not(shipped_at: nil) }
  scope :wip, -> { where(shipped_at: nil) }
  scope :users, ->(id) { includes(article_tags: :tag).where(user: id) }

  def shipped!
    self.shipped_at = Time.now
  end

  def shipped?
    shipped_at.present?
  end

  def browseable?(access_user)
    shipped? || user == access_user
  end
end
