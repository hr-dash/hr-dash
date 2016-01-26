ActiveAdmin.register MonthlyReport do
  menu parent: '月報'
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

  form do |f|
    f.inputs 'MonthlyReport Details' do
      f.input :user_id
      f.input :target_month
      f.input :status, as: :select, collection: MonthlyReport.statuses.keys
      f.input :shipped_at
      f.input :project_summary
      f.input :business_content
      f.input :looking_back
      f.input :next_month_goals
      f.input :created_at
      f.input :updated_at
    end
    f.actions
  end
end
