ActiveAdmin.register MonthlyReport do
  permit_params { MonthlyReport.column_names }

  index do
    selectable_column
    id_column
    column :user_id
    column :target_month
    column :status
    column :shipped_at
    column :project_summary
    column :business_content
    column :looking_back
    column :next_month_goals
    column :created_at
    column :updated_at
    actions
  end
end
