# frozen_string_literal: true
ActiveAdmin.register GroupAssignment do
  menu parent: 'グループ'
  active_admin_action_log
  permit_params { GroupAssignment.column_names }

  controller do
    def scoped_collection
      super.includes :group, :user
    end
  end

  index do
    id_column
    column :group
    column :user
    column :created_at
    actions
  end
end
