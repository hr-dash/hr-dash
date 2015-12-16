class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
