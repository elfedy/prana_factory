class Category < ActiveRecord::Base
  VALID_NAME_AND_DESCRIPTION_REGEX = /\A[A-Z].*/

  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validates :name, :description,
            format: { with: VALID_NAME_AND_DESCRIPTION_REGEX, message: "debe empezar con mayúscula" }

  has_many :products, :dependent => :destroy
  has_many :packages
  has_many :skus

  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :packages
end
