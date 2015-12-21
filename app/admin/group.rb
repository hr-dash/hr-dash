ActiveAdmin.register Group do
  permit_params %w(group_name deleted_at)
end
