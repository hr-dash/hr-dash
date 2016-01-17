class MonthlyReportsController < ApplicationController
  def index
    @monthly_reports = MonthlyReport.page params[:page]
  end

  def mine
    @target_year = (params[:target_year] || Time.current.year).to_i
    @monthly_reports = my_reports_in_year(@target_year)
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

  def edit
    target_month = Time.parse(params[:target_month]).gmtime
  rescue
    target_month = nil
  ensure
    @monthly_report = current_user.monthly_reports.find_by_target_month target_month
    redirect_to action: :mine if @monthly_report.nil?
  end

  def update
    @monthly_report = current_user.monthly_reports.where(id: params[:id]).first
    @monthly_report.update_attributes!(permitted_params) do |report|
      assign_relational_params(report)
    end

    redirect_to @monthly_report
  rescue
    redirect_to action: :edit
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

  def my_reports_in_year(year)
    reports = MonthlyReport.year(year).where(user: current_user)

    (1..12).map do |month|
      target_month = Time.zone.local(year, month)
      report = reports.find { |r| r.target_month == target_month }
      report ||= MonthlyReport.new(user: current_user, target_month: target_month)
      report.registrable_term? ? report : nil
    end.compact
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
