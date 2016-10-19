include Warden::Test::Helpers

module RequestHelpers
  def login(user = nil, admin: false, operator: false)
    user ||= FactoryGirl.create(:user)

    case
    when admin
      FactoryGirl.create(:user_role, :admin, user: user)
    when operator
      FactoryGirl.create(:user_role, :operator, user: user)
    end

    login_as user
  end
end
