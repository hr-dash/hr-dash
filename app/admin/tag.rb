ActiveAdmin.register Tag do
  csv_importable
  permit_params { Tag.column_names }
end
