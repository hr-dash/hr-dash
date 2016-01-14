ActiveAdmin.register Tag do
  permit_params { Tag.column_names }
end
