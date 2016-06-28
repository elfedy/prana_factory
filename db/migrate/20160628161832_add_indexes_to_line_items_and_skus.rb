class AddIndexesToLineItemsAndSkus < ActiveRecord::Migration
  def change
    add_index :line_items, :sku_id
    add_index :line_items, :order_id
    add_index :line_items, :checkout_id

    add_index :skus, :category_id
    add_index :skus, :product_id
    add_index :skus, :package_id
  end
end
