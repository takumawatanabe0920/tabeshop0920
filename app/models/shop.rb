class Shop < ApplicationRecord
  validates :shopname, presence: true, length: { maximum: 50 }
  validates :category, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :charge, presence: true
  validates :place, presence: true, length: { maximum: 50 }
  belongs_to :user

  scope :recent, -> { order(created_at: :desc)}
end
