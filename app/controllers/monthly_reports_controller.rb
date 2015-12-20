class MonthlyReportsController < ApplicationController
  def index
  end

  def show
    @monthly_report = MonthlyReport.find(params[:id])
  end

  def new
    @monthly_report = MonthlyReport.new
  end
end
