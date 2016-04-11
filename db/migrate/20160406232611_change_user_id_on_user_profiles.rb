class ChangeUserIdOnUserProfiles < ActiveRecord::Migration
  def change
    remove_index :user_profiles, :user_id
    add_index :user_profiles, :user_id, unique: true 
    change_column :user_profiles, :user_id, :integer, null: false
  end
end
