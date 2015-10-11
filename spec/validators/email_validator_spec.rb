require 'rails_helper'

describe EmailValidator, type: :validator do
  let(:model_class) do
    Struct.new(:email_address) do
      include ActiveModel::Validations

      def self.name
        'DummyModel'
      end

      validates :email_address, email: true
    end
  end

  describe '#validate_each' do
    let(:user) { model_class.new(email_address) }

    context 'with invalid format address' do
      let(:email_address) { 'hoge@@huga@example.com' }
      it { expect(user).not_to be_valid }
    end

    context 'with valid format address' do
      let(:email_address) { 'hoge@example.com' }
      it { expect(user).to be_valid }
    end
  end
end
