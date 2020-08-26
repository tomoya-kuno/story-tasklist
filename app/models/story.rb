class Story < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, length: { maximum: 555 }
  validates :card_color, presence: true
end
