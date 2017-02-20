# frozen_string_literal: true
ActiveAdmin.register HelpText do
  active_admin_action_log
  permit_params { HelpText.column_names }
  actions :all, except: [:new, :create, :destroy]

  index do
    id_column
    column :category
    column :help_type
    column :target
    column :body
    actions
  end

  show do
    attributes_table do
      row :id
      row :category
      row :help_type
      row :target
      row :body do |help_text|
        pre { help_text.body }
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :category, input_html: { disabled: true }
      f.input :help_type, input_html: { disabled: true }
      f.input :target, input_html: { disabled: true }
      f.input :body
    end
    f.actions
  end
end
