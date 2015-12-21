ActiveAdmin.register MonthlyReportTag do
  permit_params %w(monthly_report_id tag_id)

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
