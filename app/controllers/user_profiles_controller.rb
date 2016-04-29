class UserProfilesController < ApplicationController
  def show
    @profile = UserProfile.find(params[:id])
  end

  def edit
    @profile = UserProfile.find_by!(id: params[:id], user: current_user)
  end

  def update
    @profile = UserProfile.find_by!(id: params[:id], user: current_user)
    if @profile.update(permitted_params)
      redirect_to @profile
    else
      @profile.errors.full_messages.each { |msg| flash[:error] = msg }
      render :edit
    end
  end

  private

  def permitted_params
    params.require(:user_profile)
      .permit(:self_introduction, :blood_type, :birthday)
  end
end
