class Product < ActiveRecord::Base
  VALID_NAME_REGEX = /\A[A-Z].*/

  validates :name, presence: true
  validates :name, uniqueness: { scope: :category_id , message: "ya existe para la categoría"}
  validates :name, format: { with: VALID_NAME_REGEX }

  belongs_to :category
  delegate :packages, :to => :category, :prefix => true, :allow_nil => true
  has_many :skus, :dependent => :destroy

  has_attached_file :image, styles: { buy: "100x127", show:"200x254"  }
  validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }


  def create_skus
    if self.valid?
      self.category_packages.each do |package|
        sku = self.category.skus.build(product_id: self.id, package_id: package.id)
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
          sku.price = sku.package_premium_price
        else
          sku.price = sku.package_normal_price
        end
        sku.save
      end
    end
  end
end
