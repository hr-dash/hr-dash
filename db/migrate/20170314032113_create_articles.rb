class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :body
      t.datetime :shipped_at

      t.timestamps
    end
  end
end
