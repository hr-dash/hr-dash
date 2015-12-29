class UserProfilesController < ApplicationController
  def new
    @profile = UserProfile.new
    @user = current_user
  end

  def create
    UserProfile.create! permitted_params
    redirect_to profile_sample_index_path
  end

  def edit
    @profile = UserProfile.find_by(user_id: current_user.id) 
    @user = current_user
  end

  def update
    profile = UserProfile.find_by(user_id: current_user.id)
    profile.update! permitted_params
    redirect_to profile_sample_index_path
  end

  private

  def permitted_params
    params.require(:user_profile)
      .permit(:user_id, :self_introduction, :gender, :blood_type, :birthday)
  end
end
