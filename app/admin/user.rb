ActiveAdmin.register User do

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

PERMIT_COLUMUNS = %w( name group_id employee_code email entry_date beginner_flg deleted_at created_at updated_at encrypted_password reset_password_token reset_password_sent_at remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip)
permit_params PERMIT_COLUMUNS
end
