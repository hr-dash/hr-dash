# frozen_string_literal: true
ActiveAdmin.register Tag do
  csv_importable validate: false
  active_admin_action_log
  permit_params { Tag.column_names }
  actions :all, except: [:destroy]

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :status, as: :select, collection: Tag.statuses.keys
    end
    f.actions
  end

  batch_action 'fixedにする' do |ids|
    Tag.where(id: ids).each(&:fixed!)
    redirect_to collection_path, notice: "#{ids.size}個のタグをfixedにしました"
  end

  batch_action 'ignoredにする' do |ids|
    Tag.where(id: ids).each(&:ignored!)
    redirect_to collection_path, notice: "#{ids.size}個のタグをignoredにしました"
  end
end
