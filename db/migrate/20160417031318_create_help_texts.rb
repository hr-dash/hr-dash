class CreateHelpTexts < ActiveRecord::Migration
  def change
    create_table :help_texts do |t|
      t.string :category
      t.string :help_type
      t.string :target
      t.text :body

      t.timestamps null: false
    end

    add_index :help_texts, [:category, :help_type]
  end
end
