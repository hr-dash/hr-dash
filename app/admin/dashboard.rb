ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel '未登録タグ', id: :unfixed_tags do
          unfixed_tags = Tag.unfixed
          if unfixed_tags.present?
            table_for(unfixed_tags.order(created_at: :desc)) do
              column(:name) { |t| link_to(t.name, admin_tag_path(t)) }
            end
          else
            para '未登録のタグはありません'
          end
        end
      end
    end
  end # content
end
