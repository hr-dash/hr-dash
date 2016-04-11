ActiveAdmin.register MonthlyReportComment do
  menu parent: '月報'
  active_admin_action_log
  permit_params { MonthlyReportComment.column_names }

  index do
    selectable_column
    id_column
    column :user
    column :comment
    column :monthly_report
    column :created_at
    actions
  end

  filter :user
  filter :monthly_report_id
  filter :comment

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :user
      f.input :monthly_report_id
      f.input :comment
    end
    f.actions
  end
end
