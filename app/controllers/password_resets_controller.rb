class PasswordResetsController < Devise::PasswordsController
  layout false

  def new; end

  def create
    user = User.find_by(email: params["email"])

    if user&.active_for_authentication?
      user.send_reset_password_instructions
    else
      flash[:error] = '有効なメールアドレスではありません。'
      redirect_to new_password_reset_path
    end
  end

  def edit; end

  def update; end
end
