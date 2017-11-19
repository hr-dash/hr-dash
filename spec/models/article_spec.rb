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
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_length_of(:title).is_at_most(100) }
      it { is_expected.to validate_length_of(:body).is_at_most(5000) }
    end

    context 'when article is wip' do
      subject { build(:article) }
      it { is_expected.to be_valid }
      it_behaves_like 'common validations'
    end

    context 'when article is shipped' do
      subject { build(:shipped_article) }
      it { is_expected.to be_valid }
      it_behaves_like 'common validations'

      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_presence_of(:article_tags) }
    end
  end

  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :article_tags }
    it { is_expected.to have_many :tags }
  end
end
