# custom validator for email.
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    msg = 'メールアドレスの形式が正しくありません。'
    record.errors[attribute] << (options[:message] || msg) unless value =~ regex
  end
end
