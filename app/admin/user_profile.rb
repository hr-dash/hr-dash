# frozen_string_literal: true
ActiveAdmin.register UserProfile do
  menu parent: 'ユーザー', priority: 2
  active_admin_action_log
  permit_params { UserProfile.column_names }
  actions :all, except: [:new, :create, :destroy]

  controller do
    def scoped_collection
      super.includes :user
    end
  end

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

  show do
    attributes_table do
      row :id
      row :user
      row :self_introduction
      row('血液型', &:blood_type_i18n)
      row :birthday
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :user, input_html: { disabled: true }
      f.input :blood_type, as: :select, collection: UserProfile.blood_types_i18n.invert
      f.input :self_introduction
      f.input :birthday, as: :datepicker
    end
    f.actions
  end
end
