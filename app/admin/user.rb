ActiveAdmin.register User do
  params = %w(name group_id employee_code email entry_date beginner_flg)
  params.concat(%w(deleted_at password password_confirmation))
  permit_params params

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
    column :reset_password_sent_at
    column :remember_created_at
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
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
  filter :reset_password_sent_at
  filter :remember_created_at
  filter :sign_in_count
  filter :current_sign_in_at
  filter :last_sign_in_at
  filter :current_sign_in_ip
  filter :last_sign_in_ip

  form do |f|
    f.inputs 'User Details' do
      f.inputs :name
      f.inputs :group_id
      f.inputs :employee_code
      f.inputs :email
      f.inputs :entry_date
      f.inputs :beginner_flg
      f.inputs :deleted_at
      f.inputs :password
      f.inputs :password_confirmation
    end
    f.actions
  end
end
