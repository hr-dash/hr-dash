# frozen_string_literal: true
class DailyReportCommentsController < ActionController::Base
  def create
    comment = DailyReportComment.new(permitted_params)
    comment.user = current_user

    if comment.save
      mail = Mailer::Notify.daily_report_commented(comment.id)
      mail.deliver_now if mail.present?
      redirect_to comment_path(comment)
    else
      flash_errors(comment)
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    comment = current_user.daily_report_comments.find(params[:id])
    render partial: 'daily_reports/new_comment', locals: { comment: comment, attr: "edit-comment#{comment.id}" }
  end

  def update
    comment = current_user.daily_report_comments.find(params[:id])
    if comment.update(permitted_params)
      redirect_to comment_path(comment)
    else
      flash_errors(comment)
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    comment = current_user.daily_report_comments.find(params[:id])
    comment.destroy
    redirect_to comment.daily_report
  end

  private

  def flash_errors(comment)
    flash.now[:error] = comment.errors.full_messages
  end

  def comment_path(comment)
    daily_report_path(comment.daily_report, anchor: "comment-#{comment.id}")
  end

  def permitted_params
    params.require(:daily_report_comment).permit(:comment, :daily_report_id)
  end
end
