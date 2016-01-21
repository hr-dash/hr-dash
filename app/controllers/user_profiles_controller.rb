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
    @profile = current_user.user_profile
  end

  def update
    profile = UserProfile.find_by(user_id: current_user.id)
    profile.update! add_user_id_to_params
    redirect_to profile_sample_index_path
  end

  private

  def add_user_id_to_params
    permitted_params.merge(user_id: current_user.id)
  end

  def permitted_params
    params.require(:user_profile)
      .permit(:self_introduction, :gender, :blood_type, :birthday)
  end
end
