class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :status, null: false, default: 0
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :tags, :name
  end
end
