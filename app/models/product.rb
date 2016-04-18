class Product < ActiveRecord::Base
  belongs_to :category
  has_many :skus, :dependent => :destroy
end
