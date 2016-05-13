class Sku < ActiveRecord::Base
  default_scope { order(product_id: :asc) }

  validates :product_id, :package_id, presence: true
  validates_associated :products, :packages

  belongs_to :category
  belongs_to :product
  belongs_to :package

  has_many :line_items
end
