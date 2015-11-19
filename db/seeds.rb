AdminUser.destroy_all
User.destroy_all
MonthlyReport.destroy_all
Tag.destroy_all

AdminUser.create(email: 'test@develop.co.jp', password: 'test2000')
AdminUser.create(email: 'test2@develop.co.jp', password: 'test2000')

5.times { FactoryGirl.create(:monthly_report_tag) }
