# frozen_string_literal: true

class MonthlyReportLikesController < ApplicationController
  def create
    MonthlyReportLike.create(user: current_user, monthly_report_id: params[:monthly_report_id])
    @monthly_report = MonthlyReport.find(params[:monthly_report_id])
    render 'monthly_reports/change_like_status'
  end

  def destroy
    MonthlyReportLike.find_by(user: current_user, monthly_report_id: params[:monthly_report_id]).destroy
    @monthly_report = MonthlyReport.find(params[:monthly_report_id])
    render 'monthly_reports/change_like_status'
  end
end
