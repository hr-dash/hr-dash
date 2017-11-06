# frozen_string_literal: true

class MonthlyReportLikesController < ApplicationController 
  def create
    MonthlyReportLike.create(user: current_user, monthly_report_id: params[:monthly_report_id])
  end

  def destroy
    MonthlyReportLike.find_by(user: current_user, monthly_report_id: params[:monthly_report_id]).destroy
  end
end
