class Sku < ActiveRecord::Base
  default_scope { order(product_id: :asc) }

  validates :product_id, :package_id, presence: true
  validates_associated :product, :package

  belongs_to :category
  belongs_to :product
  belongs_to :package

  delegate :normal_price, :premium_price, :identifier, :to => :package, :prefix => true
  delegate :name, :to => :product, :prefix => true
  delegate :premium, :to => :product

  has_many :line_items
end
