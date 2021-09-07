class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.references :user, index: true
      t.integer :role, null: false

      t.timestamps null: false
    end
  end
end
