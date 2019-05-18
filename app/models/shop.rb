class Shop < ApplicationRecord
  mount_uploader :picture, PictureUploader
  validates :shopname, presence: true, length: { maximum: 50 }
  validates :category, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :charge, presence: true
  validates :place, presence: true, length: { maximum: 50 }
  belongs_to :user

  scope :recent, -> { order(created_at: :desc)}

  has_many :favorites, foreign_key: "like_id", dependent: :destroy
  has_many :shops, through: :favorites, source: :user
end
