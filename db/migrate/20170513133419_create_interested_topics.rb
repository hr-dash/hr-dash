# frozen_string_literal: true
class CreateInterestedTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :interested_topics do |t|
      t.integer :user_profile_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
    add_index :interested_topics, :user_profile_id
    add_index :interested_topics, :tag_id
  end
end
