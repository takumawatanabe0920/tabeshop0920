class Shop < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :shopname, presence: true, length: { maximum: 50 }
  validates :category, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :charge, presence: true
  validates :place, presence: true, length: { maximum: 50 }


  scope :recent, -> { order(created_at: :desc)}
  has_many :favorites
  belongs_to :admin
  has_many :reviews
  has_many :users, through: :reviews


  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end
