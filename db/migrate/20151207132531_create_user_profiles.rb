class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.text :self_introduction
      t.integer :gender, default: 0, null: false
      t.integer :blood_type, default: 0, null: false
      t.date :birthday

      t.timestamps null: false
    end
  end
end
