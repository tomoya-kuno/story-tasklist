class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      # taskの題名
      t.string :content
      # taskの内容
      t.string :status
      # "done" or "not-done"
      t.date :start_on
      t.time :start_at
      # 開始日時
      t.date :end_on
      t.time :end_at
      # 終了日時

      t.timestamps
    end
  end
end
