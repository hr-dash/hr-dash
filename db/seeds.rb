# frozen_string_literal: true

[
  ActiveAdminActionLog,
  Article,
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
  user = FactoryBot.create(:user, email: 'test@example.com', password: 'Passw0rd')
  FactoryBot.create(:user_role, :admin, user: user)

  FactoryBot.create(:user, email: 'testuser@example.com', password: 'Passw0rd')

  5.times { FactoryBot.create(:monthly_report, :shipped, :with_tags, :with_comments, :with_likes) }
  5.times { FactoryBot.create(:article, :shipped, :with_tags, :with_comments) }
  10.times { |i| FactoryBot.create(:announcement, published_date: Time.current.ago(i.days)) }
else
  user = User.create(name: 'admin',
                     email: 'test@example.com',
                     password: 'Passw0rd',
                     employee_code: 'x',
                     entry_date: Date.today,
                     beginner_flg: true)
  UserRole.create(user: user, role: :admin)
end
