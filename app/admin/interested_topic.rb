# frozen_string_literal: true
ActiveAdmin.register InterestedTopic do
  menu parent: 'ユーザー', priority: 4
  active_admin_action_log
  permit_params { InterestedTopic.column_names }

  controller do
    def scoped_collection
      super.includes :user_profile, :tag
    end
  end

  index do
    selectable_column
    id_column
    column :user_profile
    column :tag
    actions
  end

  filter :user_profile_id
  filter :tag

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :user_profile_id
      f.input :tag
    end

    f.actions
  end
end
