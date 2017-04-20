# frozen_string_literal: true
class LikesController < ApplicationController
  before_action :set_likable
  def create
    @likable.liked_by(current_user)
    render 'likes/switch_like'
  end

  def destroy
    @likable.unliked_by(current_user)
    render 'likes/switch_like'
  end

  private

  def set_likable
    @likable = params[:likable_type].constantize.find(params[:likable_id])
  end
end
