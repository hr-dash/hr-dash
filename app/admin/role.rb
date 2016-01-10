ActiveAdmin.register Role do
  permit_params { Role.column_names }
end
