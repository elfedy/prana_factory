class Category < ActiveRecord::Base
  VALID_NAME_AND_DESCRIPTION_REGEX = /\A[A-Z].*/

  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validates :name, :description,
            format: { with: VALID_NAME_AND_DESCRIPTION_REGEX, message: "debe empezar con mayúscula" }

  has_many :products, :dependent => :destroy
  has_many :packages
  has_many :skus

  has_attached_file :image, styles: { show:"400x400" }
  validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :packages
end
