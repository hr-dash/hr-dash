# frozen_string_literal: true
class UserProfilesController < ApplicationController
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
end
