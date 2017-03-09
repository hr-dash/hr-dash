class PasswordResetsController < Devise::PasswordsController
  layout false

  def new; end

  def create
    user = User.find_for_database_authentication(email: params[:email])

    if user.try!(:active_for_authentication?)
      user.send_reset_password_instructions
    else
      flash[:error] = '有効なメールアドレスではありません。'
      redirect_to new_password_reset_path
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.reset_password_token = params[:reset_password_token]
  end

  def update
    user = User.reset_password_by_token(update_params)

    if user.errors.present?
      flash[:error] = user.errors.full_messages
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = 'パスワードが変更されました。'
      redirect_to new_session_path
    end
  end

  private

  def update_params
    params.require(:user).permit(:password, :password_confirmation, :reset_password_token)
  end
end
