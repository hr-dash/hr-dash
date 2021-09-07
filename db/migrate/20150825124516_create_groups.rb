class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :description
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
