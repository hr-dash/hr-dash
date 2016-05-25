ActiveAdmin.register UserProfile do
  menu parent: 'ユーザー'
  active_admin_action_log
  permit_params { UserProfile.column_names }
  actions :all, except: [:new, :create, :destroy]

  index do
    id_column
    column :user
    column :blood_type, :blood_type_i18n
    column :birthday
    column :updated_at
    actions
  end

  filter :user
  filter :blood_type, as: :select, collection: UserProfile.blood_types
  filter :self_introduction
  filter :birthday
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :user, input_html: { disabled: true }
      f.input :blood_type, as: :select, collection: UserProfile.blood_types.keys
      f.input :self_introduction
      f.input :birthday, as: :datepicker
    end
    f.actions
  end
end
