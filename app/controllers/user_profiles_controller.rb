class UserProfilesController < ApplicationController
  def new
    @profile = UserProfile.new
    @user = current_user
  end

  def create
    UserProfile.create! add_user_id_to_params
    redirect_to profile_sample_index_path
  end

  def edit
    @profile = UserProfile.find_by(user_id: current_user.id)
    @user = current_user
  end

  def update
    profile = UserProfile.find_by(user_id: current_user.id)
    profile.update! add_user_id_to_params
    redirect_to profile_sample_index_path
  end

  private

  def add_user_id_to_params
    profile = permitted_params
    profile[:user_id] = current_user.id
    profile
  end

  def permitted_params
    params.require(:user_profile)
      .permit(:self_introduction, :gender, :blood_type, :birthday)
  end
end
