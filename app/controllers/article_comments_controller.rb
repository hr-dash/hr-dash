# frozen_string_literal: true

class ArticleCommentsController < ApplicationController
  def create
    @comment = ArticleComment.new(permitted_params.merge(user: current_user))

    if @comment.save
      # TODO: Mailer
      redirect_to comment_path
    else
      flash_errors
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    render partial: 'shared/new_comment', locals: { comment: comment, attr: "edit-comment#{comment.id}", hidden: :article_id }
  end

  def update
    if comment.update(permitted_params)
      redirect_to comment_path
    else
      flash_errors
      redirect_back comment_path
    end
  end

  def destroy
    comment.destroy
    redirect_to comment.article
  end

  private

  def comment
    @comment ||= current_user.article_comments.find(params[:id])
  end

  def flash_errors
    flash.now[:error] = @comment.errors.full_messages
  end

  def comment_path
    article_path(@comment.article, anchor: "comment-#{comment.id}")
  end

  def permitted_params
    params.require(:article_comment).permit(:comment, :article_id)
  end
end
