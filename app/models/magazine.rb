class Magazine < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :readers, through: :subscriptions


  def email_list
    self.readers.map {|person| person.email}.join(";")
    # readers.pluck(:email).join(";") same but better than line 7
  end

  def self.most_popular
    self.all.max_by {|mag| mag.subscriptions.length}
    # includes(:subscriptions).all.max_by {|mag| mag.subscriptions.length} only runs two querys and better than line 12
  end

end