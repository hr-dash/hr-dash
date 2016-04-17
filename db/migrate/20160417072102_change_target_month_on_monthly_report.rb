class ChangeTargetMonthOnMonthlyReport < ActiveRecord::Migration
  def change
    change_column :monthly_reports, :target_month, :date
  end
end
