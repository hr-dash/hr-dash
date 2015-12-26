ActiveAdmin.register Group do
  permit_params :group_name, :deleted_at
end
