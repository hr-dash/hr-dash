class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :user, index: true
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end
  end
end
