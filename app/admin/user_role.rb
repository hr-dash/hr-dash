ActiveAdmin.register UserRole do
  menu parent: 'ユーザー'
  permit_params { UserRole.column_names }

  index do
    selectable_column
    id_column
    column :user
    column :admin
    column :updated_at
    actions
  end
end
