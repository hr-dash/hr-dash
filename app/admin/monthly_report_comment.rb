ActiveAdmin.register MonthlyReportComment do
  permit_params %w(user_id comment monthly_report_id)

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
