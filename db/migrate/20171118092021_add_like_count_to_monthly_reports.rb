class AddLikeCountToMonthlyReports < ActiveRecord::Migration[5.0]
  def self.up
    add_column :monthly_reports, :likes_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :monthly_reports, :likes_count
  end
end
