ActiveAdmin.register MonthlyReport do
  permit_params MonthlyReport.column_names

  index do
    selectable_column
    id_column
    column :user_id
    column :project_summary
    column :used_technology
    column :responsible_business
    column :business_content
    column :looking_back
    column :next_month_goals
    column :month
    column :year
    column :created_at
    column :updated_at
    actions
  end
end
