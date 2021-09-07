class CreateGroupAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :group_assignments do |t|
      t.references :group, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
