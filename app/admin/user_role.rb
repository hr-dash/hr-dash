ActiveAdmin.register UserRole do
  permit_params { UserRole.column_names }
end
