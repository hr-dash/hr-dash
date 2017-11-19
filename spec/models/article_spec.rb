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

RSpec.describe Article, type: :model do
  describe 'Validations' do
    shared_examples 'common validations' do
      it do
        is_expected.to validate_presence_of(:user)
        is_expected.to validate_length_of(:title).is_at_most(100)
        is_expected.to validate_length_of(:body).is_at_most(5000)
      end
    end

    context 'when article is wip' do
      subject { build(:article) }
      it { is_expected.to be_valid }
      it_behaves_like 'common validations'
    end

    context 'when article is shipped' do
      subject { build(:shipped_article) }
      it_behaves_like 'common validations'
      it do
        is_expected.to be_valid
        is_expected.to validate_presence_of(:title)
        is_expected.to validate_presence_of(:body)
        is_expected.to validate_presence_of(:article_tags)
      end
    end
  end

  describe 'Relations' do
    it do
      is_expected.to belong_to :user
      is_expected.to have_many :comments
      is_expected.to have_many :article_tags
      is_expected.to have_many :tags
    end
  end
end
