ActiveAdmin.register Group do
  csv_importable
  permit_params { Group.column_names }
end
