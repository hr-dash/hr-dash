class ChangeTargetMonthOnMonthlyReport < ActiveRecord::Migration[6.0]
  def change
    change_column :monthly_reports, :target_month, :date
  end
end
