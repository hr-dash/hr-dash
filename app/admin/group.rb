ActiveAdmin.register Group do
  csv_importable
  active_admin_action_log
  permit_params { Group.column_names }
  actions :all, except: [:destroy]

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row 'メンバー' do |group|
        group.users.each do |user|
          div { user.name }
        end
      end
      row :deleted_at
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :description
      f.input :deleted_at, as: :datepicker
    end
    f.actions
  end
end
