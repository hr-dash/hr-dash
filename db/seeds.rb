User.destroy_all
MonthlyReport.destroy_all
Tag.destroy_all

if Rails.env.development?
  user = FactoryGirl.create(:user, email: 'test@example.com', password: 'password')
  FactoryGirl.create(:user_role, :admin, user: user)

  FactoryGirl.create(:user, email: 'testuser@example.com', password: 'password')

  5.times { FactoryGirl.create(:monthly_report_tag) }
else
  user = User.create(name: 'admin',
                     email: 'test@example.com',
                     password: 'password',
                     employee_code: 'x',
                     entry_date: Date.today,
                     beginner_flg: true)
  UserRole.create(user: user, admin: true)
end
