class MonthlyReportsController < ApplicationController
  def index
    users = User.where('name LIKE ?', "%#{params[:name]}%")
    @monthly_reports = MonthlyReport.released.where(user: users).page params[:page]
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
    @monthly_report = MonthlyReport.new(target_month: target_month, user: current_user)
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

  def copy
    target_month = Time.mktime params[:target_month][0..3], params[:target_month][4, 5]
    @monthly_report = MonthlyReport.new(target_month: target_month, user: current_user).try(:set_prev_monthly_report)
    render action: :new
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
