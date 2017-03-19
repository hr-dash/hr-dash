# frozen_string_literal: true
# == Schema Information
#
# Table name: article_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  comment    :text
#  article_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RSpec.describe ArticleComment, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :article }
  end

  describe 'Validations' do
    subject { build(:article_comment) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:article) }
    it { is_expected.to validate_presence_of(:comment) }
    it { is_expected.to validate_length_of(:comment).is_at_most(3000) }
  end
end
