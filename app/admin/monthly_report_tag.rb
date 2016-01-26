ActiveAdmin.register MonthlyReportTag do
  menu parent: '月報'
  permit_params { MonthlyReportTag.column_names }

  index do
    selectable_column
    id_column
    column :monthly_report_id
    column :tag_id
    column :created_at
    column :updated_at
    actions
  end
end
