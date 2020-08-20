class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 12 }
  validates :content, presence: true, length: { maximum: 255 }
  
  # カレンダー用
  def start_time
    self.start_date
  end
  
end