# frozen_string_literal: true

# == Schema Information
#
# Table name: article_tags
#
#  id         :integer          not null, primary key
#  tag_id     :integer          not null
#  article_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RSpec.describe ArticleTag, type: :model do
  describe 'Relations' do
    it do
      is_expected.to belong_to :tag
      is_expected.to belong_to :article
    end
  end

  describe 'Validations' do
    subject { build(:article_tag) }
    it do
      is_expected.to be_valid
      is_expected.to validate_presence_of(:tag)
      is_expected.to validate_presence_of(:article)
    end
  end
end
