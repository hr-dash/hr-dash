ActiveAdmin.register UserRole do
  menu parent: 'ユーザー'
  active_admin_action_log
  permit_params { UserRole.column_names }

  controller do
    def scoped_collection
      super.includes :user
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :admin
    column :updated_at
    actions
  end
end
