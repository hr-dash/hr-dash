class UserProfilesController < ApplicationController
  before_action :correct_user!, only: [:edit, :update]

  def show
    @profile = UserProfile.find(params[:id])
  end

  def edit
    @profile = UserProfile.find(params[:id])
  end

  def update
    @profile = UserProfile.find(params[:id])
    if @profile.update(permitted_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  private

  def permitted_params
    params.require(:user_profile)
      .permit(:self_introduction, :gender, :blood_type, :birthday)
  end

  def correct_user!
    profile_id = current_user.user_profile.id
    redirect_to root_path unless profile_id == params[:id].to_i
  end
end
