ActiveAdmin.register User do
  menu parent: 'ユーザー'
  csv_importable validate: false,
                 after_batch_import: ->(file) { User.last(file.csv_lines.size).each(&:create_profile) }
  active_admin_action_log
  actions :all, except: [:destroy]
  permit_params :name, :employee_code, :email, :entry_date, :beginner_flg,
                :deleted_at, :password, :password_confirmation, :gender

  controller do
    def scoped_collection
      super.includes :groups
    end

    private

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :gender, :gender_i18n
    column :employee_code
    column :entry_date
    column :beginner_flg
    column :deleted_at
    actions do |user|
      br
      link_to 'PW変更', edit_password_admin_user_path(user)
    end
  end

  filter :name
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
      f.input :gender, as: :select, collection: User.genders.keys
      f.input :employee_code
      f.input :email
      f.input :entry_date, as: :datepicker
      f.input :beginner_flg
      f.input :deleted_at, as: :datepicker
    end
    f.actions
  end

  action_item :change_password, only: [:edit, :show] do
    link_to 'PW変更', edit_password_admin_user_path(user)
  end

  member_action :edit_password, method: :get do
    @user = resource
  end

  member_action :update_password, method: :patch do
    @user = resource
    @user.assign_attributes(password_params)

    if @user.save
      ActiveAdminActionLog.create do |log|
        log.user = current_user
        log.resource = resource
        log.path = resource_path
        log.action = action_name
      end

      redirect_to action: :index
    else
      flash[:error] = @user.errors.full_messages
      redirect_to :back
    end
  end
end
