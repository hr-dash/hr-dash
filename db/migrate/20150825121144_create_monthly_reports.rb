class CreateMonthlyReports < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_reports do |t|
      t.integer :user_id,       null: false
      t.datetime :target_month, null: false, index: true
      t.datetime :shipped_at
      t.text :project_summary
      t.text :business_content
      t.text :looking_back
      t.text :next_month_goals

      t.timestamps null: false
    end
  end
end
