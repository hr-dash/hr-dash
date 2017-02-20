# frozen_string_literal: true
ActiveAdmin.register User do
  menu parent: 'ユーザー'
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

    def action_log(user:, resource:, path:, action:)
      ActiveAdminActionLog.create do |log|
        log.user = user
        log.resource = resource
        log.path = path
        log.action = action
      end
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

  action_item :import_users, only: :index do
    link_to 'ユーザーをインポートする', input_csv_admin_users_path
  end

  collection_action :input_csv, method: :get

  collection_action :import_csv, method: :post do
    unless params[:csv]
      flash[:error] = 'CSVファイルを指定してください'
      redirect_back(fallback_location: admin_root_path)
      return
    end

    users = []
    errors = []
    index = 1 # CSVヘッダー行
    CSV.table(params[:csv].tempfile, encoding: 'sjis').each do |line|
      index += 1
      user = User.new(line.to_h)
      if user.valid?
        users << user
      else
        errors += user.errors.full_messages.map { |msg| "(#{index}行目)#{msg}" }
      end
    end

    if errors.blank?
      users.each(&:save!)
      flash[:success] = "#{users.size}名のユーザーがインポートされました"
      redirect_to action: :index
    else
      flash[:error] = errors.join(' ')
      redirect_back(fallback_location: admin_root_path)
    end
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
      action_log(user: current_user,
                 resource: resource,
                 path: resource_path,
                 action: action_name)

      redirect_to action: :index
    else
      flash[:error] = @user.errors.full_messages
      redirect_back(fallback_location: admin_root_path)
    end
  end

  member_action :delete_monthly_report, method: :delete do
    monthly_reports = resource.monthly_reports
    if !resource.active_for_authentication? && monthly_reports.destroy_all
      action_log(user: current_user,
                 resource: resource,
                 path: resource_path,
                 action: action_name)

      flash[:success] = '月報を削除しました'
    else
      flash[:error] = '月報の削除に失敗しました'
    end

    redirect_back(fallback_location: admin_root_path)
  end

  action_item :delete_monthly_report, only: :show do
    unless user.active_for_authentication?
      link_to('月報を削除する',
              delete_monthly_report_admin_user_path(user),
              method: :delete,
              data: { confirm: '本当に削除してもよろしいですか？' })
    end
  end
end
