class SessionsController < Devise::SessionsController
  layout false

  before_action :reset_session, only: :create

  def password_reset
    reset_session
    redirect_to new_password_reset_path
  end
end
