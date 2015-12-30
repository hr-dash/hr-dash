module UserProfilesHelper
  def male?(profile)
    profile.gender == 'male'
  end

  def female?(profile)
    profile.gender == 'female'
  end

  def gender_hidden?(profile)
    profile.gender == 'gender_hidden'
  end

  def blood_a?(profile)
    profile.blood_type == 'a'
  end

  def blood_b?(profile)
    profile.blood_type == 'b'
  end

  def blood_ab?(profile)
    profile.blood_type == 'ab'
  end

  def blood_o?(profile)
    profile.blood_type == 'o'
  end

  def blood_hidden?(profile)
    profile.blood_type == 'blood_hidden'
  end

  def add_class(profile, item)
    send("#{item}?", profile) ? 'active' : ''
  end
end
