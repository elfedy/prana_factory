class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  def add_sku(sku_id)
    current_item = line_items.find_by_sku_id(sku_id)
    sku = Sku.find(sku_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(price: sku.price, sku_id: sku_id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
