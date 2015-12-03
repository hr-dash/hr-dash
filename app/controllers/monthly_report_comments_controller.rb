class MonthlyReportCommentsController < ApplicationController
  def create
    MonthlyReportComment.create!(permitted_params) do |comment|
      comment.user = current_user
    end
    head :ok
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
    params.require(:comment).permit(:comment, :monthly_report_id)
  end
end
