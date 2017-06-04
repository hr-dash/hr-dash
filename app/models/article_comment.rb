# frozen_string_literal: true
# == Schema Information
#
# Table name: article_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  comment    :text
#  article_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleComment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user, presence: true
  validates :article, presence: true
  validates :comment, presence: true, length: { maximum: 3000 }
end
