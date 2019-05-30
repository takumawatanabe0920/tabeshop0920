class Shop < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :shopname, presence: true, length: { maximum: 50 }
  validates :category, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :charge, presence: true
  validates :place, presence: true, length: { maximum: 50 }


  scope :recent, -> { order(created_at: :desc)}
  belongs_to :user
  has_many :favorites

end
