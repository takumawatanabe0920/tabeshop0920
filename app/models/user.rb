class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :timeoutable, :Lockable, omniauth_providers: %i[facebook twitter line]

 has_many :social_profiles, dependent: :destroy
 def social_profile(provider)
   social_profiles.select{ |sp| sp.provider == provider.to_s }.first
 end

 def set_values(omniauth)
  return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
  credentials = omniauth['credentials']
  info = omniauth['info']

  access_token = credentials['refresh_token']
  access_secret = credentials['secret']
  credentials = credentials.to_json
  username = info['username']
  # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end





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

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        # userモデルが持っているカラムをそれぞれ定義していく
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.username = auth.info.username
        user.uid = auth.uid
        user.provider = auth.provider

        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.

      end
    end
  end
end
