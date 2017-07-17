# frozen_string_literal: true
class DailyReportsController < InheritedResources::Base
  before_action :assign_saved_report, only: [:edit, :update]

  def index
    @q = DailyReport.includes(user: :groups).ransack(search_params)
    @daily_reports = @q.result(distinct: true).released.order('shipped_at desc').page params[:page]
  end

  def user
    @target_year = (params[:target_year] || Date.today.year).to_i
    @target_month = (params[:target_month] || Date.today.month).to_i
    @report_user = User.find(params[:user_id])
    @daily_reports = user_reports_in_year_month(@target_year, @target_month, @report_user)
  end

  def show
    @daily_report = DailyReport.includes(comments: { user: :user_profile }).find(params[:id])
    raise(Forbidden, 'can not see wip reports of other users') unless @daily_report.browseable?(current_user)
  end

  def new
    target_date = params[:target_date] || Date.today
    @daily_report = current_user.daily_reports.build(target_date: target_date)
  end

  def create
    @daily_report = DailyReport.new(permitted_params.merge!(user: current_user))
    @daily_report.shipped_at ||= Time.current unless params[:wip]
    shipped_at_was = @daily_report.shipped_at_was
    if @daily_report.save
      daily_report_notify(shipped_at_was)
      redirect_to @daily_report
    else
      flash_errors(@daily_report)
      render :new
    end
  end

  def edit; end

  def update
    @daily_report.assign_attributes(permitted_params)
    @daily_report.shipped_at ||= Time.current unless params[:wip]
    shipped_at_was = @daily_report.shipped_at_was

    if @daily_report.save
      daily_report_notify(shipped_at_was)
      redirect_to @daily_report
    else
      flash_errors(@daily_reports)
      render :edit
    end
  end

  def copy
    @daily_report = DailyReport.new(target_date: params[:target_date], user: current_user).set_prev_daily_report
    render :new
  end

  private

  def assign_saved_report
    @daily_report = current_user.daily_reports.find params[:id]
    @saved_shipped_at = @daily_report.shipped_at
  end

  def flash_errors(daily_report)
    flash.now[:error] = daily_report.errors.full_messages
  end

  def user_reports_in_year_month(year, month, report_user)
    reports = DailyReport.year_month(year, month).includes(:user).where(user: report_user)
    (Date.new(year, month, 1)..Date.new(year, month, 1).end_of_month).map do |date|
      report = reports.find { |r| r.target_date == date }
      report ||= DailyReport.new(user: report_user, target_date: date)
      report.registrable_term? ? report : nil
    end.compact
  end

  def permitted_params
    params.require(:daily_report).permit(
      :target_date,
      :business_content,
      :looking_back,
    )
  end

  def search_params
    return unless params[:q]
    set_target_date_start
    set_target_date_end

    search_conditions = [
      :user_groups_id_eq,
      :user_name_cont,
      :target_date_gteq,
      :target_date_lteq,
    ]

    params.require(:q).permit(search_conditions)
  end

  def set_target_date_start
    params[:q][:target_date_gteq] = Date.new(params[:year_start].to_i, params[:month_start].to_i, params[:day_start].to_i)
  rescue
    return
  end

  def set_target_date_end
    params[:q][:target_date_lteq] = Date.new(params[:year_end].to_i, params[:month_end].to_i, params[:day_end].to_i)
  rescue
    return
  end

  def daily_report_notify(shipped_at_was)
    return if shipped_at_was.present? || params[:wip]
    Mailer::Notify.daily_report_registration(current_user.id, @daily_report.id).deliver_now
  end
end
