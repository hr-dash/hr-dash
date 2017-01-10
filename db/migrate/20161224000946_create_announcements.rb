class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.date :published_date, null: false

      t.timestamps null: false
    end
  end
end
