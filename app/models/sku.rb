class Sku < ActiveRecord::Base
  default_scope { order(product_id: :asc) }

  belongs_to :category
  belongs_to :product
  belongs_to :package
end
