class Checkout < ActiveRecord::Base
  validates :name, :telephone, :address, presence: true
  
  has_many :line_items, :dependent => :destroy

  DELIVERY_TIME_OPTIONS = [ "9:00h a 12:00h", "12:00h a 15:00h", "15:00h a 18:00h", "18:00h a 21:00h"]

  def add_line_items_from_order(order)
    order.line_items.each do |item|
      item.order_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
