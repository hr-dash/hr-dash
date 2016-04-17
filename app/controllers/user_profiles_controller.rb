class UserProfilesController < ApplicationController
  before_action :correct_user?, only: [:edit, :update]

  def show
    @profile = UserProfile.find(params[:id])
  end

  def edit
    @profile = UserProfile.find(params[:id])
  end

  def update
    profile = UserProfile.find_by(user_id: current_user.id)
    profile.update! add_user_id_to_params
    redirect_to profile_sample_index_path
  end

  private

  def permitted_params
    params.require(:user_profile)
      .permit(:self_introduction, :gender, :blood_type, :birthday)
  end

  def correct_user?
    redirect_to root_path unless current_user.user_profile.id == params[:id].to_i
  end
end
