ActiveAdmin.register ActiveAdminActionLog do
  menu label: 'ログ'
  actions :index, :show

  controller do
    def scoped_collection
      super.includes :user, :resource
    end
  end

  index do
    id_column
    column :user
    column :resource_type
    column :resource_id
    column :resource
    column :action
    column :changes_log
    column :created_at
    actions
  end
end
