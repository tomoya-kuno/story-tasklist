class AddWeekDayIndexToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :week_day_index, :string
  end
end
