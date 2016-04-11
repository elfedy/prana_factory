class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :products, :dependent => :destroy

  accept_nested_attributes_for => :products
end
