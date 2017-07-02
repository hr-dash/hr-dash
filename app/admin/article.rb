# frozen_string_literal: true
ActiveAdmin.register Article do
  menu parent: '記事'
  active_admin_action_log
  permit_params { Article.column_names }
  actions :all, except: [:new, :create]

  controller do
    def scoped_collection
      super.includes :user, article_tags: :tag
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :title
    column :shipped_at
    actions
  end

  filter :user
  filter :title
  filter :shipped_at
  filter :article_tags

  show do
    attributes_table do
      row :id
      row :user
      row :title
      row :body
      row :shipped_at
      row :article_tags do
        resource
          .tags.pluck(:name)
          .map { |name| content_tag(:div, name) }
          .join.html_safe
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'Article Details' do
      f.input :user
      f.input :shipped_at, as: :datepicker
      f.input :title
      f.input :body
    end
    f.actions
  end
end
