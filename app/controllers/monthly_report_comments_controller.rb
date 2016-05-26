class MonthlyReportCommentsController < ApplicationController
  def create
    comment = MonthlyReportComment.new(permitted_params)
    comment.user = current_user

    if comment.save
      redirect_to comment_path(comment)
    else
      flash_errors(comment)
      redirect_to :back
    end
  end

  def edit
    comment = current_user.monthly_report_comments.find(params[:id])
    render partial: 'monthly_reports/new_comment', locals: { comment: comment, attr: "edit-comment#{comment.id}" }
  end

  def update
    comment = current_user.monthly_report_comments.find(params[:id])
    if comment.update(permitted_params)
      redirect_to comment_path(comment)
    else
      flash_errors(comment)
      redirect_to :back
    end
  end

  def destroy
    comment = current_user.monthly_report_comments.find(params[:id])
    comment.destroy
    redirect_to comment.monthly_report
  end

  private

  def flash_errors(comment)
    flash[:error] = comment.errors.full_messages
  end

  def comment_path(comment)
    monthly_report_path(comment.monthly_report, anchor: "comment-#{comment.id}")
  end

  def permitted_params
    params.require(:monthly_report_comment).permit(:comment, :monthly_report_id)
  end
end
