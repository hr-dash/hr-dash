ActiveAdmin.register MonthlyReportTag do
  menu parent: '月報'
  active_admin_action_log
  permit_params { MonthlyReportTag.column_names }

  index do
    selectable_column
    id_column
    column :monthly_report
    column :tag
    actions
  end

  filter :monthly_report_id
  filter :tag

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :monthly_report_id
      f.input :tag
    end
    f.actions
  end
end
