module UserProfilesHelper
  def labels
    {
      'gender_hidden' => '秘密',
      'male'          => '男性',
      'female'        => '女性',
      'blood_hidden'  => '秘密',
      'a'             => 'A型',
      'b'             => 'B型',
      'ab'            => 'AB型',
      'o'             => 'O型'
    }
  end

  def add_class(profile, item)
    profile.send("#{item}?") ? 'active' : ''
  end
end
