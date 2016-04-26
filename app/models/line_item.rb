class LineItem < ActiveRecord::Base
  belongs_to :sku
  belongs_to :order
  belongs_to :checkout

  def identifier
    self.sku.product.category.name + ' ' + self.sku.product.name + ' x' + self.sku.package.identifier
  end

  def total_price
    sku.price * quantity
  end
end
