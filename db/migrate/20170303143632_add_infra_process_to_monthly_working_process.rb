class AddInfraProcessToMonthlyWorkingProcess < ActiveRecord::Migration
  def change
    add_column :monthly_working_processes, :process_structure, :boolean, null: false, default: false
    add_column :monthly_working_processes, :process_trouble, :boolean, null: false, default: false
  end
end
