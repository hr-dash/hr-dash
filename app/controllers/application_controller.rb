class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def current_user
    @current_user ||= super && User.includes(:role).find(@current_user.id)
  end

  def authenticate_admin_user!
    redirect_to :root unless current_user.admin?
  end
end
