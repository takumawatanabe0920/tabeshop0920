class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop


  validates_uniqueness_of :shop_id, scope: :user_id

  def self.ranking
    self.group(:shop_id).order('count_shop_id DESC').limit(10).count(:shop_id)
  end
end
