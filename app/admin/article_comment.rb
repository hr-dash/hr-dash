# frozen_string_literal: true
ActiveAdmin.register ArticleComment do
  menu parent: 'ノート'
  active_admin_action_log
  permit_params { ArticleComment.column_names }
  actions :all, except: [:new, :create]

  controller do
    def scoped_collection
      super.includes :user, :article
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :comment
    column :article
    column :created_at
    actions
  end

  filter :user
  filter :article_id
  filter :comment

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :user
      f.input :comment
    end
    f.actions
  end
end
