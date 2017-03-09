# frozen_string_literal: true
[
  ActiveAdminActionLog,
  User,
  Group,
  MonthlyReport,
  Tag,
  HelpText,
  Announcement,
].map(&:destroy_all)

Dir.glob("#{Rails.root}/db/seeds/*.yml").each do |yaml_filename|
  klass = File.basename(yaml_filename, '.yml').classify.constantize

  File.open(yaml_filename) do |load_target_yaml|
    YAML.safe_load(load_target_yaml).each { |record| klass.create!(record) }
  end
end

if Rails.env.development?
  user = FactoryGirl.create(:user, email: 'test@example.com', password: 'Passw0rd')
  FactoryGirl.create(:user_role, :admin, user: user)

  FactoryGirl.create(:user, email: 'testuser@example.com', password: 'Passw0rd')

  5.times { FactoryGirl.create(:monthly_report, :shipped, :with_tags, :with_comments) }
  10.times { |i| FactoryGirl.create(:announcement, published_date: Time.current.ago(i.days)) }
else
  user = User.create(name: 'admin',
                     email: 'test@example.com',
                     password: 'Passw0rd',
                     employee_code: 'x',
                     entry_date: Date.today,
                     beginner_flg: true)
  UserRole.create(user: user, role: :admin)
end
