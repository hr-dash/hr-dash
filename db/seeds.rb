User.destroy_all
MonthlyReport.destroy_all
Tag.destroy_all

user = FactoryGirl.create(:user, email: 'test@example.com', password: 'password')
FactoryGirl.create(:user_role, :admin, user: user)
FactoryGirl.create(:user, email: 'testuser@example.com', password: 'password')

5.times { FactoryGirl.create(:monthly_report_tag) }
