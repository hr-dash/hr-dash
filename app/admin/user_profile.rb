ActiveAdmin.register UserProfile do
  menu parent: 'ユーザー'
  permit_params { UserProfile.column_names }
end
