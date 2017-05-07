# frozen_string_literal: true
class ArticleCommentsController < ApplicationController
  def create
    comment = ArticleComment.new(permitted_params)
    comment.user = current_user

    if comment.save
      # TODO: Mailer
      redirect_to comment_path(comment)
    else
      flash_errors(comment)
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    comment = current_user.article_comments.find(params[:id])
    render partial: 'articles/new_comment', locals: { comment: comment, attr: "edit-comment#{comment.id}" }
  end

  def update
    comment = current_user.article_comments.find(params[:id])
    if comment.update(permitted_params)
      redirect_to comment_path(comment)
    else
      flash_errors(comment)
      redirect_back comment_path(comment)
    end
  end

  def destroy
    comment = current_user.article_comments.find(params[:id])
    comment.destroy
    redirect_to comment.article
  end

  private

  def flash_errors(comment)
    flash.now[:error] = comment.errors.full_messages
  end

  def comment_path(comment)
    article_path(comment.article, anchor: "comment-#{comment.id}")
  end

  def permitted_params
    params.require(:article_comment).permit(:comment, :article_id)
  end
end
