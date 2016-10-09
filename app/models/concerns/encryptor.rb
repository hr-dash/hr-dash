module Encryptor
  extend ActiveSupport::Concern

  CIPHER = ENV['ENCRYPTOR_CIPHER']
  PASS = ENV['ENCRYPTOR_PASS']
  SALT = ENV['ENCRYPTOR_SALT']

  module ClassMethods
    def encrypt(data)
      return unless data

      cipher = OpenSSL::Cipher::Cipher.new(CIPHER)
      cipher.encrypt
      cipher.pkcs5_keyivgen(PASS, SALT)
      Base64.strict_encode64(cipher.update(data) + cipher.final)
    end

    def decrypt(data)
      return unless data

      cipher = OpenSSL::Cipher::Cipher.new(CIPHER)
      cipher.decrypt
      cipher.pkcs5_keyivgen(PASS, SALT)
      cipher.update(Base64.decode64(data)) + cipher.final
    end

    def encrypted_columns(*columns)
      columns.each do |column|
        define_getter(column)
        define_setter(column)

        define_method("#{column}_changed?") do
          self["encrypted_#{column}_changed?"]
        end
      end
    end

    def define_getter(column)
      define_method(column) do
        self.class.decrypt(self["encrypted_#{column}"])
      end
    end

    def define_setter(column)
      define_method("#{column}=") do |value|
        self["encrypted_#{column}"] = self.class.encrypt(value)
      end
    end
  end
end
