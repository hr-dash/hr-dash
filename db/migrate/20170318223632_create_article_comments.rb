class CreateArticleComments < ActiveRecord::Migration[5.0]
  def change
    create_table :article_comments do |t|
      t.belongs_to :user, null: false
      t.text :comment
      t.belongs_to :article, null: false

      t.timestamps null: false
    end
  end
end
