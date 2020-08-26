class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :content
      t.string :status
      t.string :card_color
      t.string :favorite_score
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
