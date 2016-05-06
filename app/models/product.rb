class Product < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :category
  has_many :skus, :dependent => :destroy
end
