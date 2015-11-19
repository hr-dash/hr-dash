class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.belongs_to :group, index: true
      t.string :employee_code
      t.string :email
      t.date :entry_date
      t.boolean :beginner_flg
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
