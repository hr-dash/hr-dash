class SessionsController < Devise::SessionsController
  layout false

  before_action :reset_session_before_login, only: :create

  def password_reset
    reset_session
    redirect_to new_password_reset_path
  end

  private

  def reset_session_before_login
    user_return_to = session[:user_return_to]
    reset_session

    # friendly forwarding
    session[:user_return_to] = user_return_to if user_return_to
  end
end
