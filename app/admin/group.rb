ActiveAdmin.register Group do
  permit_params { Group.column_names }
end
