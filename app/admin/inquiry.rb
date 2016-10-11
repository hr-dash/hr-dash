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
      div { inquiry.body.first(15) }
    end
    column :referer
    column :admin_memo do |inquiry|
      div { inquiry.admin_memo.first(15) }
    end
    column :created_at do |inquiry|
      div { inquiry.created_at.to_date }
    end
    actions
  end
end
