ActiveAdmin.register MonthlyReport do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  PERMIT_COLUMUNS  = %w(user_id project_summary used_technology responsible_business business_content looking_back next_month_goals month year)
  permit_params PERMIT_COLUMUNS
end
