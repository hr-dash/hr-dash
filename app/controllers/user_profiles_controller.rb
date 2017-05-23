# frozen_string_literal: true
class UserProfilesController < ApplicationController
  def index
    @q = UserProfile.includes(user: :groups).ransack(search_params)
    @user_profiles = @q.result.page params[:page]
  end

  def show
    @profile = UserProfile.find(params[:id])
  end

  def edit
    @profile = UserProfile.find_by!(id: params[:id], user: current_user)
  end

  def update
    @profile = UserProfile.find_by!(id: params[:id], user: current_user)
    @profile.assign_attributes valid_profile_params
    if @profile.save
      redirect_to @profile
    else
      flash.now[:error] = @profile.errors.full_messages
      render :edit
    end
  end

  private

  def permitted_params
    params.require(:user_profile)
          .permit(:self_introduction, :blood_type, :birthday)
  end

  def valid_profile_params
    return permitted_params if UserProfile.blood_types.include? permitted_params[:blood_type]
    permitted_params.reject { |key, _| key == 'blood_type' }
  end

  def search_params
    return unless params[:q]
    if params[:entry_year_start].present? && params[:entry_month_start].present?
      params[:q][:user_entry_date_gteq] = Date.new(params[:entry_year_start].to_i, params[:entry_month_start].to_i, 1)
    end
    if params[:entry_year_end].present? && params[:entry_month_end].present?
      params[:q][:user_entry_date_lteq] = Date.new(params[:entry_year_end].to_i, params[:entry_month_end].to_i, 1).end_of_month
    end
    conditions = [:user_name_cont, :self_introduction_cont, :user_entry_date_gteq, :user_entry_date_lteq]
    params.require(:q).permit(conditions)
  end
end
