class Category < ActiveRecord::Base
  validates :name, :description, presence: true
  has_many :products, :dependent => :destroy
  has_many :packages
  has_many :skus

  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :packages

  def create_skus_when_creating_products(product)
  end
end
