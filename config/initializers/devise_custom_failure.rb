# see: https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-when-the-user-can-not-be-authenticated
class DeviseCustomFailure < Devise::FailureApp
  def redirect_url
    new_session_path
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
