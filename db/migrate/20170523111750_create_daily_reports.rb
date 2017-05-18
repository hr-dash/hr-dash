class CreateDailyReports < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_reports do |t|
      t.integer :user_id, null: false
      t.date :target_date, null: false, index: true
      t.datetime :shipped_at
      t.text :business_content
      t.text :looking_back
      t.integer :comments_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end
