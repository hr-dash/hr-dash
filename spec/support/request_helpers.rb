include Warden::Test::Helpers

module RequestHelpers
  def login(user = nil)
    user ||= FactoryGirl.create(:user)
    login_as user
  end
end
