# frozen_string_literal: true

# == Schema Information
#
# Table name: article_tags
#
#  id         :integer          not null, primary key
#  tag_id     :integer          not null
#  article_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleTag < ApplicationRecord
  belongs_to :article
  belongs_to :tag
  delegate :name, to: :tag

  validates :article, presence: true
  validates :tag, presence: true
end
