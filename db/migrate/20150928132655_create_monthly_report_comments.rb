class CreateMonthlyReportComments < ActiveRecord::Migration
  def change
    create_table :monthly_report_comments do |t|
      t.belongs_to :user, null: false
      t.text :comment
      t.belongs_to :monthly_report, null: false

      t.timestamps null: false
    end
  end
end
