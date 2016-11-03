class CreateMonthlyWorkingProcesses < ActiveRecord::Migration
  def change
    create_table :monthly_working_processes do |t|
      t.references :monthly_report, index: true, foreign_key: true
      t.boolean :process_definition, null: false, default: false
      t.boolean :process_design, null: false, default: false
      t.boolean :process_implementation, null: false, default: false
      t.boolean :process_test, null: false, default: false
      t.boolean :process_operation, null: false, default: false
      t.boolean :process_analysis, null: false, default: false
      t.boolean :process_training, null: false, default: false

      t.timestamps null: false
    end
  end
end
