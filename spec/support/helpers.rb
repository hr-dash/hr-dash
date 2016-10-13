module Helpers
  def generate_random_password
    required_chars = ['A'..'Z', 'a'..'z', '0'..'9'].map do |range|
      chars = range.to_a
      chars[rand(chars.size)]
    end

    Faker::Internet.password + required_chars.join
  end
end
