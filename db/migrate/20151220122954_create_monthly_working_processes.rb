class CreateMonthlyWorkingProcesses < ActiveRecord::Migration
  def change
    create_table :monthly_working_processes do |t|
      t.references :monthly_report, index: true, foreign_key: true
      t.integer :process, null: false

      t.timestamps null: false
    end
  end
end
