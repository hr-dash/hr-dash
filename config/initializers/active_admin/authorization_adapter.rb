class AuthorizationAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    case
    when [User, UserRole].include?(subject)
      user.admin?
    else
      true
    end
  end
end
