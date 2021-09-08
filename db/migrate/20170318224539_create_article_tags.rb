class CreateArticleTags < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tags do |t|
      t.references :tag, null: false
      t.references :article, null: false

      t.timestamps null: false
    end
  end
end
