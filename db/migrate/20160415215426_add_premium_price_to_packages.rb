class AddPremiumPriceToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :premium_price, :integer
    add_column :packages, :normal_price, :integer
    add_column :products, :premium, :boolean, :default => false
  end
end
