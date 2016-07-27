include Warden::Test::Helpers

module RequestHelpers
  def login(user = nil, admin: false)
    user ||= FactoryGirl.create(:user)
    FactoryGirl.create(:user_role, :admin, user: user) if admin
    login_as user
  end
end
