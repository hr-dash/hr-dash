class MoveGenderColumnToUsers < ActiveRecord::Migration
  def change
    remove_column(:user_profiles, :gender, :integer)
    add_column(:users, :gender, :integer, default: 0, null: false)
  end
end
