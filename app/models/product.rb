class Product < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :category
  has_many :skus, :dependent => :destroy

  def create_skus
    if self.valid?
      self.category.packages.each do |package|
        sku = self.category.skus.create(product_id: self.id, package_id: package.id)
        if self.premium
          sku.price = package.premium_price
        else
          sku.price = package.normal_price
        end
        sku.save
      end
    end
  end

  def update_skus
    if self.valid?
      self.skus.each do |sku|
        if self.premium
          sku.price = sku.package.premium_price
        else
          sku.price = sku.package.normal_price
        end
        sku.save
      end
    end
  end
end
