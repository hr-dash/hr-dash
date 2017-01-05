ActiveAdmin.register Announcement do
  active_admin_action_log
  permit_params { Announcement.column_names }

  index do
    id_column
    column :title
    column :body do |announcement|
      div { truncate(announcement.body, length: 15) }
    end
    column :published_date
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :body
      f.input :published_date, as: :datepicker
    end
    f.actions
  end
end
