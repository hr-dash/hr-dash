# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  body       :text
#  shipped_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :article do
    association :user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }

    trait :wip do
      shipped_at { nil }
    end

    trait :shipped do
      shipped_at { Time.current }
    end

    trait :with_comments do
      transient do
        comment_size 3
      end

      after(:create) do |article, evaluator|
        evaluator.comment_size.times do
          create(:article_comment, article: article)
        end
      end
    end

    trait :with_tags do
      transient do
        tag_size 3
      end

      after(:build) do |article, evaluator|
        evaluator.tag_size.times do
          article.article_tags << build(:article_tag, article: article)
        end
      end
    end

    factory :shipped_article, traits: %i[shipped with_tags]
  end
end
