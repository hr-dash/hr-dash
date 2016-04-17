class MonthlyReportsController < ApplicationController
  def index
    users = User.where('name LIKE ?', "%#{params[:name]}%")
    @monthly_reports = MonthlyReport.released.where(user: users).page params[:page]
  end

  def mine
    @target_year = (params[:target_year] || Date.current.year).to_i
    @monthly_reports = my_reports_in_year(@target_year)
  end

  def show
    @monthly_report = MonthlyReport.find(params[:id])
  end

  def new
    target_month = params[:target_month] || Date.current.last_month.beginning_of_month
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
    @monthly_report = current_user.monthly_reports.find params[:id]
  end

  def update
    @monthly_report = current_user.monthly_reports.find(params[:id])
    @monthly_report.assign_attributes(permitted_params)
    assign_relational_params(@monthly_report)

    if @monthly_report.save
      redirect_to @monthly_report
    else
      render :edit
    end
  end

  private

  def assign_relational_params(report)
    report.status = params[:wip] ? :wip : :shipped
    report.monthly_working_processes = working_processes(report)
    report.tags = monthly_report_tags
  end

  def working_processes(monthly_report)
    return [] if params[:working_process].blank?

    params[:working_process]
      .select { |process| MonthlyWorkingProcess.processes.keys.include?(process) }
      .map { |process| MonthlyWorkingProcess.new(monthly_report: monthly_report, process: process) }
  end

  def monthly_report_tags
    tags = params[:monthly_report][:monthly_report_tags].try!(:split, ',').try!(:map) do |tag|
      Tag.find_or_create_by(name: tag.strip)
    end
    tags || []
  end

  def my_reports_in_year(year)
    reports = MonthlyReport.year(year).where(user: current_user)

    (1..12).map do |month|
      target_month = Date.new(year, month, 1)
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
