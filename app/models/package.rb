class Package < ActiveRecord::Base
  validates :quantity, :unit, :normal_price, :premium_price, presence: true
  validates :quantity, :normal_price, :premium_price,
             numericality: { only_integer: true, message: "debe ser un entero" }
  validates :quantity, uniqueness: { scope: [:category_id, :unit], message: "ya existe para la categoría" }

  default_scope { order(quantity: :asc) }

  belongs_to :category
  has_many :skus, :dependent => :destroy

  def identifier
    self.quantity.to_s + self.unit
  end

  def create_skus
    if self.valid?
      self.category.products.each do |product|
        sku = self.category.skus.create(product_id: product.id, package_id: self.id)
        if product.premium
          sku.price = self.premium_price
        else
          sku.price = self.normal_price
        end
        sku.save
      end
    end
  end

  def update_skus
    if self.valid?
      self.skus.each do |sku|
        if sku.product.premium
          sku.price = self.premium_price
        else
          sku.price = self.normal_price
        end
        sku.save
      end
    end
  end
end
