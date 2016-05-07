[
  ActiveAdminActionLog,
  User,
  Group,
  MonthlyReport,
  Tag,
  HelpText,
].map(&:destroy_all)

Dir.glob("#{Rails.root}/db/seeds/*.yml").each do |yaml_filename|
  klass = File.basename(yaml_filename, '.yml').classify.constantize

  File.open(yaml_filename) do |load_target_yaml|
    YAML.load(load_target_yaml).each { |record| klass.create!(record) }
  end
end

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
