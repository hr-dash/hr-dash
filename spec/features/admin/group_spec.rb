# frozen_string_literal: true

describe 'Admin::Group', type: :feature do
  before { login(admin: true) }
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let!(:assignment) { create(:group_assignment, group: group, user: user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_groups_path }
    it 'should open the index page' do
      expect(page_title).to have_content('グループ')
      expect(page).to have_content(group.name)
      expect(page).to have_content('作成する')
      expect(page).not_to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_group_path(group) }
    it 'should open the show page' do
      expect(page_title).to have_content(group.name)
      expect(page).to have_content(user.name)
    end
  end

  describe '#create' do
    let(:new_group) { build(:group) }
    before do
      visit new_admin_group_path
      fill_in '名前', with: new_group.name
      fill_in 'メールアドレス', with: new_group.email
      fill_in '説明', with: new_group.description
      click_on 'グループを作成'
    end

    it 'should create the new group' do
      expect(page_title).to have_content(new_group.name)
      expect(page).to have_content(new_group.description)
    end
  end

  describe '#update' do
    let(:new_description) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_group_path(group)
      fill_in '説明', with: new_description
      click_on 'グループを更新'
    end

    it 'should update the group' do
      expect(page_title).to have_content(group.name)
      expect(current_path).to eq admin_group_path(group)
      expect(page).to have_content(new_description)
      expect(group.reload.description).to eq new_description
    end
  end

  describe '#update_group_assign', js: true do
    let!(:another_user) { create(:user) }
    before do
      visit edit_group_assign_admin_group_path(group)
      find('#s2id_group_assign_form').find('.select2-search-choice-close').click
      page.execute_script "$('option[value=#{another_user.id}]').attr('selected', true)"
      find('input[name=commit]').trigger('click')
      sleep 0.4
    end

    it 'should assign user to group' do
      expect(page_title).to have_content(group.name)
      expect(current_path).to eq admin_group_path(group)
      expect(group.users).to include(another_user)
      expect(group.users).not_to include(user)
    end
  end

  describe '#import_csv' do
    before { visit import_admin_groups_path }

    context 'no input csv file' do
      before { find('input[type=submit]').click }

      it 'should open the import groups page' do
        expect(current_path).to eq do_import_admin_groups_path
        expect(page).to have_content('インポートするファイルを選択してください')
      end
    end

    context 'input valid csv file' do
      let(:file) { File.join(fixture_path, 'groups.csv') }
      let(:yamada) { Group.find_by(name: '山田') }
      let(:suzuki) { Group.find_by(name: '鈴木') }

      before do
        attach_file 'active_admin_import_model_file', file
        find('input[type=submit]').click
      end

      it 'should imoprt group by csv' do
        expect(current_path).to eq import_admin_groups_path
        expect(page).to have_content('2つのグループのインポートに成功しました')
        expect(yamada).to be_present
        expect(yamada.name).to eq '山田'
        expect(yamada.email).to eq 'yamada.group@example.com'
        expect(yamada.description).to eq '山田グループ'
        expect(suzuki).to be_present
        expect(suzuki.name).to eq '鈴木'
        expect(suzuki.email).to eq 'suzuki.group@example.com'
        expect(suzuki.description).to eq '鈴木グループ'
      end
    end
  end
end
