# frozen_string_literal: true
ActiveAdmin.register UserRole do
  menu parent: 'ユーザー'
  active_admin_action_log
  permit_params { UserRole.column_names }

  controller do
    def scoped_collection
      super.includes :user
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :role
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :role, as: :select, collection: UserRole.roles_i18n.invert
    end
    f.actions
  end
end
