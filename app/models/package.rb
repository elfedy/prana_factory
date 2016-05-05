class Package < ActiveRecord::Base
  validates :quantity, :unit, :normal_price, presence: true

  default_scope { order(quantity: :asc) }

  belongs_to :category
  has_many :skus, :dependent => :destroy

  def identifier
    self.quantity.to_s + self.unit
  end
end
