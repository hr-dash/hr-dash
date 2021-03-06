# frozen_string_literal: true

class MonthlyReportsController < ApplicationController
  before_action :assign_saved_report, only: %i[edit update]

  def index
    references = [{ user: :groups }, :monthly_working_process, { monthly_report_tags: :tag }]
    @q = MonthlyReport.includes(references).ransack(search_params)
    @monthly_reports = @q.result(distinct: true).released.order('shipped_at desc').page params[:page]
  end

  def user
    @target_year = (params[:target_year] || User.report_registrable_to.year).to_i
    @report_user = User.find(params[:user_id])
    @monthly_reports = user_reports_in_year(@target_year, @report_user)
  end

  def show
    response.headers['Cache-Control'] = 'no-cache, no-store'
    references = [{ comments: { user: :user_profile } }, { likes: { user: :user_profile } }]
    @monthly_report = MonthlyReport.includes(references).find(params[:id])
    raise(Forbidden, 'can not see wip reports of other users') unless browseable?(@monthly_report)
  end

  def new
    target_month = params[:target_month] || User.report_registrable_to.beginning_of_month
    @monthly_report = current_user.monthly_reports.build(target_month: target_month)
  end

  def create
    @monthly_report = MonthlyReport.new(permitted_params) do |report|
      report.user   = current_user
      assign_relational_params(report)
    end
    shipped_at_was = @monthly_report.shipped_at_was
    if @monthly_report.save
      monthly_report_notify(shipped_at_was)
      redirect_to @monthly_report
    else
      flash_errors(@monthly_report)
      render :new
    end
  end

  def edit; end

  def update
    @monthly_report.assign_attributes(permitted_params)
    assign_relational_params(@monthly_report)
    shipped_at_was = @monthly_report.shipped_at_was

    if @monthly_report.save
      monthly_report_notify(shipped_at_was)
      redirect_to @monthly_report
    else
      flash_errors(@monthly_report)
      render :edit
    end
  end

  def copy
    @monthly_report = MonthlyReport.new(target_month: params[:target_month], user: current_user).set_prev_monthly_report!
    render :new
  end

  private

  def assign_saved_report
    @monthly_report = current_user.monthly_reports.includes(monthly_report_tags: :tag).find params[:id]
    @saved_shipped_at = @monthly_report.shipped_at
  end

  def browseable?(monthly_report)
    monthly_report.browseable?(current_user)
  end

  def flash_errors(monthly_report)
    flash.now[:error] = monthly_report.errors.full_messages
  end

  def assign_relational_params(report)
    report.shipped! unless params[:wip]
    report.monthly_working_process = working_processes(report)
    report.tags = monthly_report_tags
  end

  def working_processes(report)
    processes_params = Array(params[:working_process])
    process = report.monthly_working_process || MonthlyWorkingProcess.new(monthly_report: report)

    process.attributes = MonthlyWorkingProcess::PROCESSES.reduce({}) do |hash, key|
      value = processes_params.include?(key)
      hash.merge!(key => value)
    end

    process
  end

  def monthly_report_tags
    tags = params[:monthly_report][:monthly_report_tags].try!(:split, ',').try!(:map) do |name|
      tag = Tag.find_or_initialize_by_name_ignore_case(name.strip)
      tag.save ? tag : nil # 許容できないタグは無視
    end.try!(:compact)

    tags || []
  end

  def user_reports_in_year(year, report_user)
    reports = MonthlyReport.year(year).includes(:user).where(user: report_user)

    (1..12).map do |month|
      target_month = Date.new(year, month, 1)
      report = reports.find { |r| r.target_month == target_month }
      report ||= MonthlyReport.new(user: report_user, target_month: target_month)
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

  def search_params
    return unless params[:q]
    params[:q][:tags_name_in] = params[:q][:tags_name_in]&.split(',')&.flatten

    search_conditions = [
      :user_groups_id_eq,
      :user_name_cont,
      :target_month_eq,
      tags_name_in: [],
    ].concat(process_conditions)

    params.require(:q).permit(search_conditions)
  end

  def process_conditions
    MonthlyWorkingProcess::PROCESSES.map do |process|
      "monthly_working_process_#{process}_eq".to_sym
    end
  end

  def monthly_report_notify(shipped_at_was)
    return if shipped_at_was.present? || params[:wip]
    Mailer::Notify.monthly_report_registration(current_user.id, @monthly_report.id).deliver_now
  end
end
