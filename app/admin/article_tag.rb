# frozen_string_literal: true
ActiveAdmin.register ArticleTag do
  menu parent: 'ノート'
  active_admin_action_log
  permit_params { ArticleTag.column_names }

  controller do
    def scoped_collection
      super.includes :article, :tag
    end
  end

  index do
    selectable_column
    id_column
    column :article
    column :tag
    actions
  end

  filter :article_id
  filter :tag

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :tag
    end
    f.actions
  end
end
