class ChangeUserIdOnUserProfiles < ActiveRecord::Migration
  def change
    change_column(:user_profiles, :user_id, :integer, null: false, unique: true)
  end
end
