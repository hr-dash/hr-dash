ActiveAdmin.register User do
  menu parent: 'ユーザー'
  csv_importable validate: false
  permit_params :name, :group_id, :employee_code, :email, :entry_date, :beginner_flg,
                :deleted_at, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :name
    column :group_id
    column :employee_code
    column :email
    column :entry_date
    column :beginner_flg
    column :deleted_at
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :group_id
  filter :employee_code
  filter :email
  filter :entry_date
  filter :beginner_flg
  filter :deleted_at
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs 'User Details' do
      f.input :name
      f.input :group
      f.input :employee_code
      f.input :email
      f.input :entry_date
      f.input :beginner_flg
      f.input :deleted_at
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
