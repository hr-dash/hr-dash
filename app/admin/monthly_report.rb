ActiveAdmin.register MonthlyReport do
  menu parent: '月報'
  active_admin_action_log
  permit_params { MonthlyReport.column_names }
  actions :all, except: [:new, :create, :destroy]

  controller do
    def scoped_collection
      super.includes :user, monthly_report_tags: :tag
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :target_month do |r|
      div { r.target_month.strftime('%Y年%m月') }
    end
    column :shipped_at
    column :project_summary
    actions
  end

  filter :user
  filter :target_month
  filter :shipped_at
  filter :project_summary
  filter :monthly_report_tags
  filter :monthly_working_processes_process, label: '担当した工程', as: :select, collection: MonthlyWorkingProcess.processes

  show do
    attributes_table do
      row :id
      row :user
      row :target_month
      row :shipped_at
      row :project_summary
      row :business_content
      row :looking_back
      row :next_month_goals
      row :monthly_report_tags do |report|
        report.monthly_report_tags.each do |tag|
          div { tag.name }
        end
      end
      row :monthly_working_processes do |report|
        report.monthly_working_processes.each do |process|
          div { process.process_i18n }
        end
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'MonthlyReport Details' do
      f.input :user
      f.input :target_month, as: :datepicker
      f.input :shipped_at, as: :datepicker
      f.input :project_summary
      f.input :business_content
      f.input :looking_back
      f.input :next_month_goals
    end
    f.actions
  end
end
