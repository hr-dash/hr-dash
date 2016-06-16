ActiveAdmin.register User do
  menu parent: 'ユーザー'
  csv_importable validate: false
  active_admin_action_log
  actions :all, except: [:destroy]
  permit_params :name, :group_id, :employee_code, :email, :entry_date, :beginner_flg,
                :deleted_at, :password, :password_confirmation, :gender

  controller do
    def scoped_collection
      super.includes :group
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :group
    column :gender, :gender_i18n
    column :employee_code
    column :email
    column :entry_date
    column :beginner_flg
    column :deleted_at
    actions
  end

  filter :name
  filter :group
  filter :gender, as: :select, collection: User.genders
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
      f.input :gender, as: :select, collection: User.genders.keys
      f.input :employee_code
      f.input :email
      f.input :entry_date, as: :datepicker
      f.input :beginner_flg
      f.input :deleted_at, as: :datepicker
    end
    f.actions
  end
end
