class MonthlyReportsController < ApplicationController
  def index
  end

  def show
    @monthly_report = MonthlyReport.find(params[:id])
  end
end
