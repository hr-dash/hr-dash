class MonthlyReportsController < ApplicationController
  def index
    @monthly_reports = MonthlyReport.page params[:page]
  end

  def mine
    @target_year = (params[:target_year] || Time.current.year).to_i
    from = Time.local(@target_year).beginning_of_year
    to = Time.local(@target_year).end_of_year
    reports = MonthlyReport.where(user: current_user, target_month: from..to)

    @monthly_reports = (1..12).map do |month|
      target_month = Time.zone.local(@target_year, month)
      report = reports.find { |r| r.target_month == target_month }
      report ||= MonthlyReport.new(user: current_user, target_month: target_month)
      report.registrable_term? ? report : nil
    end.compact
  end

  def show
    @monthly_report = MonthlyReport.find(params[:id])
  end

  def new
    target_month = params[:target_month] || Time.current.last_month.beginning_of_month
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
