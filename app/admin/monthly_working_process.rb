ActiveAdmin.register MonthlyWorkingProcess do
  menu parent: '月報'
  active_admin_action_log
  permit_params { MonthlyWorkingProcess.column_names }
  actions :index, :show

  controller do
    def scoped_collection
      super.includes(monthly_report: :user)
    end
  end

  index do
    column :monthly_report
    column :user do |process|
      user = process.monthly_report.user
      div { link_to user.name, admin_user_path(user) }
    end
    MonthlyWorkingProcess::PROCESSES.each do |key|
      column I18n.t "activerecord.attributes.monthly_working_process.#{key}" do |process|
        process[key]
      end
    end
    column :created_at
    actions
  end
end
