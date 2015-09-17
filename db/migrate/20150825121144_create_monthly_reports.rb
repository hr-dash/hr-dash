class CreateMonthlyReports < ActiveRecord::Migration
  def change
    create_table :monthly_reports do |t|
      t.integer :users_id,          null: false
      t.text :project_summary
      t.text :used_technology
      t.text :responsible_business
      t.text :business_content
      t.text :looking_back
      t.text :next_month_goals
      t.integer :month,             null: false
      t.integer :year,              null: false

      t.timestamps null: false
    end
  end
end
