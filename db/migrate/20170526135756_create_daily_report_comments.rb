class CreateDailyReportComments < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_report_comments do |t|
      t.integer :user_id, null: false
      t.text :comment
      t.integer :daily_report_id, null: false

      t.timestamps null: false
    end
  end
end
