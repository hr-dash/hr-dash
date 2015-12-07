class UserProfile < ActiveRecord::Base
  belongs_to :user

  enum gender: { gender_hidden: 0, male: 1, female: 2 }
  enum blood_type: { blood_hidden: 0, a: 1, b: 2, ab: 3, o: 4 }
end
