describe Encryptor, type: :model do
  class Sample
    include Encryptor
    encrypted_columns :email

    attr_accessor :encrypted_email
    # ref: http://api.rubyonrails.org/classes/ActiveRecord/AttributeMethods.html#method-i-5B-5D
    def [](attr_name)
      send(attr_name)
    end

    def []=(attr_name, value)
      send("#{attr_name}=", value)
    end
  end

  context 'included' do
    let(:sample) { Sample.new }

    describe 'define methods for encryption' do
      it { expect(Sample).to respond_to(:encrypt) }
      it { expect(Sample).to respond_to(:decrypt) }
      it { expect(Sample).to respond_to(:encrypted_columns) }

      it { expect(sample).to respond_to(:email) }
      it { expect(sample).to respond_to(:email=) }
      it { expect(sample).to respond_to(:email_changed?) }
    end

    describe 'encryption' do
      let(:sample_email) { Faker::Internet.email }
      let(:encrypted) { Sample.encrypt(sample_email) }

      before { sample.email = sample_email }

      it { expect(sample.encrypted_email).to eq encrypted }
      it { expect(sample.email).to eq sample_email }
      it { expect(sample.email).not_to eq encrypted }
    end
  end
end
