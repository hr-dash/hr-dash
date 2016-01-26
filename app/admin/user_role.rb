ActiveAdmin.register UserRole do
  menu parent: 'ユーザー'
  permit_params { UserRole.column_names }
end
