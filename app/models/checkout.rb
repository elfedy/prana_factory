class Checkout < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :telephone, :address, :delivery_date, :delivery_time, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX, message: "debe tener un formato válido" }
  validate :date_is_not_sunday

  has_many :line_items, :dependent => :destroy

  DELIVERY_TIME_OPTIONS = [ "10:00h a 13:00h", "19:00h a 22:00h" ]
  MIN_CHECKOUT_PRICE = 100

  def add_line_items_from_order(order)
    order.line_items.each do |item|
      item.order_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def date_is_not_sunday
    if delivery_date.present? && delivery_date.wday == 0
      errors.add(:delivery_date, "no puede ser Domingo")
    end
  end

end
