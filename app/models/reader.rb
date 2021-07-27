class Reader < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :magazines, through: :subscriptions

  def subscribe magazine, price
    Subscription.create(magazine_id: magazine.id, reader_id: self.id, price: price)
  end
  
  def total_subscription_price
    self.subscriptions.select{|subscription| subscription.price}.sum
    # subscriptions.sum(:price) same as line 10 but better
  end

  def cancel_subscription magazine
    subscription.find_by(magazine_id: magazine.id).destroy
  end

end