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
    it { is_expected.to belong_to :tag }
    it { is_expected.to belong_to :article }
  end

  describe 'Validations' do
    subject { build(:article_tag) }
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:tag) }
    it { is_expected.to validate_presence_of(:article) }
  end
end
