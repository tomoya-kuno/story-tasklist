class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 12 }
  validates :content, length: { maximum: 255 }
  validates :week_day_index, presence: true

  # カレンダー用
  def start_time
    self.start_on
  end
  
end