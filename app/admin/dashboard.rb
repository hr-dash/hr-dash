ActiveAdmin.register_page 'Dashboard' do
  DISPLAY_MONTHLY_REPORT_LIMIT = 10

  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      Group.active.each do |group|
        column max_width: '45%', min_width: '45%' do
          panel "最新の月報 【#{group.name}グループ】" do
            reports = MonthlyReport
                      .includes(:user)
                      .where(user_id: group.users)
                      .order(created_at: :desc)
                      .limit(DISPLAY_MONTHLY_REPORT_LIMIT)

            table_for reports do
              column(:id) { |r| link_to(r.id, admin_monthly_report_path(r)) }
              column(:user)
              column(:target_month) { |r| r.target_month.strftime('%Y年%m月') }
              column(:shipped_at) { |r| r.shipped_at.to_s }
            end
          end
        end
      end
    end

    columns do
      column do
        panel '未登録タグ', id: :unfixed_tags do
          unfixed_tags = Tag.unfixed.order(created_at: :desc)
          if unfixed_tags.present?
            table_for unfixed_tags do
              column(:name) { |t| link_to(t.name, admin_tag_path(t)) }
            end
          else
            para '未登録のタグはありません'
          end
        end
      end
    end
  end
end
