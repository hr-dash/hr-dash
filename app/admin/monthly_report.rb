ActiveAdmin.register MonthlyReport do
  params = %w(user_id project_summary used_technology responsible_business)
  params.concat(%w(business_content looking_back next_month_goals month year))
  permit_params params

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
