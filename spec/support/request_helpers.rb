# frozen_string_literal: true

include Warden::Test::Helpers

module RequestHelpers
  def login(user = nil, admin: false, operator: false)
    user ||= FactoryBot.create(:user)

    if admin
      FactoryBot.create(:user_role, :admin, user: user)
    elsif operator
      FactoryBot.create(:user_role, :operator, user: user)
    end

    login_as user
  end

  # see: http://qiita.com/saboyutaka/items/cafc2b69ae52f605c8fd
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end
