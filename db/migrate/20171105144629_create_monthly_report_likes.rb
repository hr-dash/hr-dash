class CreateMonthlyReportLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_report_likes do |t|
      t.belongs_to :user, null: false
      t.belongs_to :monthly_report, null: false

      t.timestamps null: false
    end
  end
end
