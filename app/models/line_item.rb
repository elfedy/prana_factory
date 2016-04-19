class LineItem < ActiveRecord::Base
  belongs_to :sku
  belongs_to :order

  def identifier
    self.sku.product.category.name + ' ' + self.sku.product.name + ' x' + self.sku.package.identifier
  end
end
