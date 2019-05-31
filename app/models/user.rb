class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]


  before_save { self.email.downcase! }
  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }

  has_many :shops
  has_many :favorites
  has_many :likes, through: :favorites, source: :like



  def like(shop)
    self.favorites.find_or_create_by(like_id: shop.id)
  end

  def unlike(shop)
    favorite = self.favorites.find_by(like_id: shop.id)
    favorite.destroy if favorite
  end

  def liking?(shop)
    self.likes.include?(shop)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
