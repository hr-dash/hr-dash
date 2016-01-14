class MonthlyReportsController < ApplicationController
  def index
    @monthly_reports = MonthlyReport.page params[:page]
  end

  def show
    @monthly_report = MonthlyReport.find(params[:id])
  end

  def new
    target_month = Time.current.beginning_of_month
    @monthly_report = MonthlyReport.new(target_month: target_month)
  end

  def create
    @monthly_report = MonthlyReport.new(permitted_params) do |report|
      report.user   = current_user
      assign_relational_params(report)
    end

    if @monthly_report.save
      redirect_to @monthly_report
    else
      render :new
    end
  end

  private

  def assign_relational_params(report)
    report.status = params[:wip] ? :wip : :shipped
    report.monthly_working_processes = working_processes(report)
    report.tags = monthly_report_tags
  end

  def working_processes(monthly_report)
    processes = params[:working_process].try!(:map) do |process|
      MonthlyWorkingProcess.new(monthly_report: monthly_report, process: process)
    end
    processes || []
  end

  def monthly_report_tags
    tags = params[:monthly_report][:monthly_report_tags].try!(:split, ',').try!(:map) do |tag|
      Tag.find_or_create_by(name: tag)
    end
    tags || []
  end

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
