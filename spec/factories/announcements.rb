# == Schema Information
#
# Table name: announcements
#
#  id             :integer          not null, primary key
#  title          :string           not null
#  body           :text             not null
#  published_date :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :announcement do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    published_date { Time.current.to_date }
  end
end
