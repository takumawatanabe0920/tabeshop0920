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
  has_many :reviews
  has_many :shops, through: :reviews



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

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
