class MonthlyReportsController < ApplicationController
  def index
    @monthly_reports = MonthlyReport.all
  end

  def show
    @monthly_report = MonthlyReport.find(params[:id])
  end

  def new
    target_month = Time.current.beginning_of_month
    @monthly_report = MonthlyReport.new(target_month: target_month)
  end

  def create
    @monthly_report = MonthlyReport.new(permitted_params) { |report| report.user = current_user }

    processes = params[:working_process].try!(:map) do |process|
      MonthlyWorkingProcess.new(monthly_report: @monthly_report, process: process)
    end
    @monthly_report.monthly_working_processes = processes || []

    if @monthly_report.save
      redirect_to @monthly_report
    else
      render :new
    end
  end

  private

  def permitted_params
    params.require(:monthly_report).permit(
      :target_month,
      :project_summary,
      :business_content,
      :looking_back,
      :next_month_goals,
    )
  end
end
