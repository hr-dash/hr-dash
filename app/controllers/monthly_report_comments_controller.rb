class MonthlyReportCommentsController < ApplicationController
  def create
    comment = MonthlyReportComment.new(permitted_params)
    comment.user = current_user

    if comment.save
      redirect_to comment.monthly_report
    else
      redirect_to :back
    end
  end

  def update
    comment = current_user.monthly_report_comments.find(params[:id])
    comment.update!(permitted_params)
    head :ok
  end

  def destroy
    comment = current_user.monthly_report_comments.find(params[:id])
    comment.destroy
    head :ok
  end

  private

  def permitted_params
    params.require(:monthly_report_comment).permit(:comment, :monthly_report_id)
  end
end
