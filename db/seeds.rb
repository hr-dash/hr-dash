AdminUser.destroy_all
User.destroy_all
MonthlyReport.destroy_all
Tag.destroy_all

FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

5.times { FactoryGirl.create(:monthly_report_tag) }
