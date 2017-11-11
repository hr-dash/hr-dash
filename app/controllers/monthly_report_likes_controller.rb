# frozen_string_literal: true

class MonthlyReportLikesController < ApplicationController 
  def create
    MonthlyReportLike.create(user: current_user, monthly_report: monthly_report)
    render 'monthly_reports/change_like_status'
  end

  def destroy
    MonthlyReportLike.find_by(user: current_user, monthly_report: monthly_report).destroy
    render 'monthly_reports/change_like_status'
  end

  private

  def monthly_report
    @monthly_report ||= MonthlyReport.find(params[:monthly_report_id])
  end
end
