class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 12 }
  validates :content, presence: true, length: { maximum: 255 }
end