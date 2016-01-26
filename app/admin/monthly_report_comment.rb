ActiveAdmin.register MonthlyReportComment do
  menu parent: '月報'
  permit_params { MonthlyReportComment.column_names }

  index do
    selectable_column
    id_column
    column :user_id
    column :comment
    column :monthly_report_id
    column :created_at
    column :updated_at
    actions
  end
end
