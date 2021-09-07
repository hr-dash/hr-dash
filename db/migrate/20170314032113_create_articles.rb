class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :body
      t.datetime :shipped_at
      t.integer :comments_count, null: false, default: 0

      t.timestamps
    end
  end
end
