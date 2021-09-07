class AddCommentsCountToMonthlyReports < ActiveRecord::Migration[6.0]
  def self.up
    add_column :monthly_reports, :comments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :monthly_reports, :comments_count
  end
end
