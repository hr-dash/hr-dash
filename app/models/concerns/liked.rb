# frozen_string_literal: true
module Liked
  def liked_by(user)
    likes.find_or_create_by(user: user)
  end

  def unliked_by(user)
    like = likes.find_by(user: user)
    like.destroy if like.present?
  end

  def liked_count
    likes.count
  end

  def liked_by?(user)
    likes.find_by(user: user).present?
  end
end
