class MonthlyReportsController < ApplicationController
  def index
  end

  def show
    @monthly = MonthlyReport.find(params[:id])
    @user_name = User.find(@monthly.users_id).name
  end
end
