class SessionsController < Devise::SessionsController
  layout false

  before_action :reset_session, only: :create
end
