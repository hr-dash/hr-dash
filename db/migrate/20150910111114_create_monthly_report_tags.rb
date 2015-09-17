class CreateMonthlyReportTags < ActiveRecord::Migration
  def change
    create_table :monthly_report_tags do |t|
      t.integer :monthly_report_id, null: false
      t.integer :tag_id,            null: false

      t.timestamps null: false
    end
  end
end
