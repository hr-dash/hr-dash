class CreateCreateUsers < ActiveRecord::Migration
  def change
    create_table :create_users do |t|
      t.string :name
      t.belongs_to :group, index: true, foreign_key: false
      t.integer :employee_code
      t.string :email
      t.date :entry_date
      t.boolean :beginner_flg
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
