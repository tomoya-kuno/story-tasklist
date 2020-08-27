class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 12 }
  validates :content, length: { maximum: 255 }
  validates :week_day_index, presence: true
  
  validate :date_cannot_be_in_the_past
  validate :finish_cannot_be_greater_than_start

  def date_cannot_be_in_the_past
    if (start_on.present?)&&(start_on < Date.today)
      errors.add(:start_on,"過去の日付は使用できません")
    end
  end

  def finish_cannot_be_greater_than_start
    if (start_at.present?)&&(end_at.present?)&&(start_at > end_at)
      errors.add(:end_at,"開始時刻が終了時刻を上回ることはできません")
    end
  end

  # カレンダー用
  def start_time
    self.start_on
  end
  
end