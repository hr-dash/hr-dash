ActiveAdmin.register User do
  menu parent: 'ユーザー'
  csv_importable validate: false
  active_admin_action_log
  actions :all, except: [:destroy]
  permit_params :name, :group_id, :employee_code, :email, :entry_date, :beginner_flg,
                :deleted_at, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :name
    column :group
    column :employee_code
    column :email
    column :entry_date
    column :beginner_flg
    column :deleted_at
    actions
  end

  filter :name
  filter :group
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
      f.input :entry_date, as: :datepicker
      f.input :beginner_flg
      f.input :deleted_at, as: :datepicker
    end
    f.actions
  end
end
