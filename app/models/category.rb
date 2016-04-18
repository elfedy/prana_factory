class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :products, :dependent => :destroy
  has_many :packages
  has_many :skus

  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :packages
end
