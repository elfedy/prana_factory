class Category < ActiveRecord::Base
  attr_accessor :name, :description
  validates :name, presence: true 
  has_many :products
end
