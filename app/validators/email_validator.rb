class EmailValidator < ActiveModel::EachValidator
  def validate_dach(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "メールアドレスの形式が正しくありません。")
    end
  end
end
