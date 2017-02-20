# frozen_string_literal: true
ActiveAdmin.register Inquiry do
  active_admin_action_log
  permit_params { Inquiry.column_names }
  actions :index, :show, :edit, :update

  controller do
    def scoped_collection
      super.includes :user
    end
  end

  index do
    id_column
    column :user
    column :body do |inquiry|
      div { truncate(inquiry.body, length: 15) }
    end
    column :referer
    column :admin_memo do |inquiry|
      div { truncate(inquiry.admin_memo, length: 15) }
    end
    column :created_at do |inquiry|
      div { inquiry.created_at.to_date }
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :body do |inquiry|
        pre { inquiry.body }
      end
      row :referer
      row :user_agent
      row :session_id
      row :admin_memo do |inquiry|
        pre { inquiry.admin_memo }
      end
      row :created_at
      row :updated_at
    end
  end
end
