ActiveAdmin.register UserProfile do
  menu parent: 'ユーザー'
  active_admin_action_log
  permit_params { UserProfile.column_names }
end
