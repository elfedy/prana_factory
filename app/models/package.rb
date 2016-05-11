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
end
