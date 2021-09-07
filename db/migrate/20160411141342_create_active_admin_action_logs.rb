class CreateActiveAdminActionLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :active_admin_action_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :resource_id
      t.string :resource_type
      t.string :path
      t.string :action
      t.text :changes_log

      t.timestamps null: false
    end

    add_index :active_admin_action_logs, [:resource_id, :resource_type]
  end
end
